#!/bin/bash

set -e
set -u
set -o pipefail

log_file="${1:-}"

if [ -z "$log_file" ]
then 
    echo "Usage: ./scripts/log-error-checker.sh <log-file-path>"
    exit 1
fi

check_file_exists() {
    local file_path=$1

    if [ ! -f "$file_path" ]
    then
        echo "Log file not found: $file_path"
        return 1
    fi

    echo "Log file found: $file_path"
    return 0 
}

check_errors() {
    local file_path=$1
    local error_count

    error_count=$(grep -i -c "error" "$file_path" || true)

    echo "Error count: $error_count"

    if [ "$error_count" -gt 0 ]
    then
        echo "Errors found in log file"
        return 1
    fi

    echo "No error found in log file"
    return 0
}

echo "Starting log error check"

if ! check_file_exists "$log_file"
then
    exit 1
fi

if ! check_errors "$log_file"
then
    exit 1
fi

echo "Log check completed successfully"
