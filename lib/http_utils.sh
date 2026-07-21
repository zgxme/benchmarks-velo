#!/bin/bash
# HTTP Utilities

curl_capture_or_log() {
    local output_var="$1"
    local context="$2"
    shift 2

    local curl_output
    local curl_status
    curl_output=$(curl "$@" 2>&1)
    curl_status=$?
    if [ "$curl_status" -ne 0 ]; then
        echo "${context} failed (curl exit=${curl_status}): ${curl_output:-<no error output>}" >&2
        return "$curl_status"
    fi

    printf -v "$output_var" '%s' "$curl_output"
    return 0
}
