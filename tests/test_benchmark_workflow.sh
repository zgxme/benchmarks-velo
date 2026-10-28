#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_DIR="$(mktemp -d)"
trap 'rm -rf "$TEST_DIR"' EXIT

fail() {
    echo "FAIL: $*" >&2
    exit 1
}

assert_contains() {
    local value="$1"
    local expected="$2"
    [[ "$value" == *"$expected"* ]] || fail "expected '$expected' in '$value'"
}

assert_not_contains() {
    local value="$1"
    local unexpected="$2"
    [[ "$value" != *"$unexpected"* ]] || fail "unexpected '$unexpected' in '$value'"
}

test_load_config_uses_separate_ddl_path_variable() {
    (
        source "$ROOT_DIR/benchmark.sh"
        CONFIG_FILE="$TEST_DIR/load-config.yaml"
        TEST_ROOT="$TEST_DIR"
        RESULT_DIR="$TEST_DIR/result"
        mkdir -p "$RESULT_DIR"
        cat > "$CONFIG_FILE" <<'YAML'
engine:
  connection:
    host: 127.0.0.1
parameters:
  ddl: "true"
  load: "false"
paths:
  ddl: "ddl/custom.sql"
YAML
        load_config >/dev/null
        [ "$DDL_FILE" = "ddl/custom.sql" ] || fail "DDL_FILE was not loaded"
    )
}

test_run_ddl_honors_skip_database_creation() {
    (
        source "$ROOT_DIR/benchmark.sh"
        TEST_ROOT="$TEST_DIR/ddl"
        mkdir -p "$TEST_ROOT/ddl"
        printf 'SELECT 1;\n' > "$TEST_ROOT/ddl/ddl.sql"
        DDL_FILE="ddl/ddl.sql"
        ddl_skip_database_create="true"
        local_calls=""
        engine_create_database() {
            local_calls="${local_calls}create;"
        }
        engine_run_sql_file() {
            local_calls="${local_calls}sql:$1;"
        }
        run_ddl >/dev/null
        assert_not_contains "$local_calls" "create;"
        assert_contains "$local_calls" "sql:"
    )
}

test_run_ddl_prefers_engine_specific_ddl_runner() {
    (
        source "$ROOT_DIR/benchmark.sh"
        TEST_ROOT="$TEST_DIR/ddl-engine"
        mkdir -p "$TEST_ROOT/ddl"
        printf 'SELECT 1;\n' > "$TEST_ROOT/ddl/ddl.sql"
        DDL_FILE="ddl/ddl.sql"
        ddl_skip_database_create="false"
        local_calls=""
        engine_create_database() {
            local_calls="${local_calls}create;"
        }
        engine_run_sql_file() {
            local_calls="${local_calls}generic;"
        }
        engine_run_ddl_file() {
            local_calls="${local_calls}engine;"
        }
        run_ddl >/dev/null
        assert_contains "$local_calls" "create;"
        assert_contains "$local_calls" "engine;"
        assert_not_contains "$local_calls" "generic;"
    )
}

test_run_analyze_falls_back_when_builtin_is_unsupported() {
    (
        source "$ROOT_DIR/benchmark.sh"
        local_calls=""
        run_builtin_analyze() {
            return 2
        }
        run_analyze_with_sql_file() {
            local_calls="fallback"
        }
        run_analyze >/dev/null
        [ "$local_calls" = "fallback" ] || fail "analyze fallback was not called"
    )
}

test_trino_analyze_reports_unsupported_without_database() {
    (
        source "$ROOT_DIR/benchmark.sh"
        ENGINE_TYPE="trino"
        db=""
        set +e
        run_builtin_analyze >/dev/null 2>&1
        local rc=$?
        set -e
        [ "$rc" -eq 2 ] || fail "expected Trino analyze rc=2, got $rc"
    )
}

test_clickhouse_ddl_fans_out_to_cluster_workers() {
    (
        source "$ROOT_DIR/engines/clickhouse_engine.sh"
        local fake_cli="$TEST_DIR/clickhouse"
        local fake_log="$TEST_DIR/clickhouse.log"
        cat > "$fake_cli" <<'SH'
#!/bin/bash
printf '%s\n' "$*" >> "$FAKE_CLICKHOUSE_LOG"
case "$*" in
    *--query=*)
        printf '10.0.0.2\n10.0.0.3\n'
        ;;
esac
if [[ "$*" == *--multiquery* ]]; then
    cat >/dev/null
fi
SH
        chmod +x "$fake_cli"
        export FAKE_CLICKHOUSE_LOG="$fake_log"
        CLICKHOUSE_CMD="$fake_cli"
        clickhouse_host="10.0.0.1"
        user="default"
        password=""
        db="default"
        ddl_cluster="perf_cluster"
        printf 'SELECT 1;\n' > "$TEST_DIR/ddl.sql"
        engine_run_ddl_file "$TEST_DIR/ddl.sql" >/dev/null
        local count
        count="$(grep -c -- '--multiquery' "$fake_log")"
        [ "$count" -eq 3 ] || fail "expected 3 ClickHouse DDL targets, got $count"
        grep -q -- '--host=10.0.0.1' "$fake_log" || fail "coordinator DDL missing"
        grep -q -- '--host=10.0.0.2' "$fake_log" || fail "worker 2 DDL missing"
        grep -q -- '--host=10.0.0.3' "$fake_log" || fail "worker 3 DDL missing"

        : > "$fake_log"
        ddl_cluster=""
        engine_run_ddl_file "$TEST_DIR/ddl.sql" >/dev/null
        count="$(grep -c -- '--multiquery' "$fake_log")"
        [ "$count" -eq 1 ] || fail "expected coordinator-only DDL, got $count targets"
    )
}

test_load_config_uses_separate_ddl_path_variable
test_run_ddl_honors_skip_database_creation
test_run_ddl_prefers_engine_specific_ddl_runner
test_run_analyze_falls_back_when_builtin_is_unsupported
test_trino_analyze_reports_unsupported_without_database
test_clickhouse_ddl_fans_out_to_cluster_workers

echo "All benchmark workflow tests passed."
