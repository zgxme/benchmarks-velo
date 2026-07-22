#!/bin/bash
# Doris Stream Load Utilities

run_doris_stream_load() {
    local this_label="$1"
    local input_file="$2"
    local load_scope="${3:-full file}"
    local curl_status
    local errexit_was_set="false"

    case "$-" in
        *e*)
            errexit_was_set="true"
            set +e
            ;;
    esac

    resp="$(do_curl "$this_label" "$input_file")"
    curl_status=$?

    if [ "$errexit_was_set" = "true" ]; then
        set -e
    fi

    if [ "$curl_status" -ne 0 ]; then
        [ -n "$resp" ] && echo "$resp"
        echo "[ERROR] Stream load request failed for ${db}.${table} (${load_scope}, label: ${this_label}, curl exit=${curl_status})" >&2
        exit "$curl_status"
    fi
}
