#!/bin/bash

set -e
set -u
set -o pipefail

LOG_FILE="manage-environment.log"

log_message() {
        local message=$1
        local timestamp

        timestamp=$(date "+%Y-%m-%d %H:%M:%S")

        echo "$timestamp - $message" | tee -a "$LOG_FILE"
}

validate_environment() {
    local env_name=$1

    case "$env_name" in
        dev|qa|staging|prod)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

validate_action() {
    local action=$1

    case "$action" in
        start|stop|restart|status)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

validate_compose_file() {
    if [ ! -f "docker-compose.yml" ]
    then
        log_message "Missing docker-compose.yml"
	return 1
    fi

    log_message "docker-compose.yml found"
    return 0
}

run_action() {
    local env_name=$1
    local action=$2

    case "$action" in
        start)
            log_message "Starting services for $env_name environment"
            docker compose up -d
            return $?
            ;;
        stop)
            log_message "Stopping services for $env_name environment"
            docker compose down
            return $?
            ;;
        restart)
            log_message "Restarting services for $env_name environment"
            docker compose restart
            return $?
            ;;
        status)
            log_message "Checking status for $env_name environment"
            docker compose ps
            return $?
            ;;
        *)
            echo "Unknown action: $action"
            return 1
            ;;
    esac
}

read -p "Select the environment: " env_name

if validate_environment "$env_name"
then
    echo "Selected environment: $env_name"
else
    echo "Invalid environment: $env_name"
    exit 1
fi

read -p "Select the action (start/stop/restart/status): " action

if validate_action "$action"
then
    echo "Selected action: $action"
else
    echo "Invalid action: $action"
    exit 1
fi

echo "_____Checking for docker compose file_____"

if ! validate_compose_file
then
	log_message "Docker compose validation failed"
	exit 1
fi

if run_action "$env_name" "$action"
then
    log_message "Action completed successfully"
    exit 0
else
    log_message "Action failed"
    exit 1
fi
