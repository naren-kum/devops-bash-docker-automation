#!/bin/bash

set -e
set -u
set -o pipefail

environment="${1:-}"

if [ -z "$environment" ]
then
    echo "Usage: ./scripts/deployment-precheck.sh <environment>"
    echo "Allowed values: dev, qa, staging, prod"
    exit 1
fi

print_header() {
    echo "Deployment Precheck"
    echo "-------------------"
    echo "Environment: $environment"
    echo ""
}

validate_environment() {
    local env_name=$1

    case "$env_name" in
        dev|qa|staging|prod)
            return 0
            ;;
        *)
            echo "Invalid environment name. Use dev/qa/staging/prod"
            return 1
            ;;
    esac
}

check_docker_available() {
    if ! command -v docker > /dev/null 2>&1
    then
        echo "Docker is not installed or not available in PATH"
        return 1
    fi

    echo "Docker is available"
    return 0
}

check_compose_file() {
    if [ ! -f "docker-compose.yml" ]
    then
        echo "Missing docker-compose.yml"
        return 1
    fi

    echo "docker-compose.yml found"
    return 0
}

check_env_file() {
    if [ ! -f ".env" ]
    then
        echo "WARNING: .env file not found. Continuing because it is optional for this lab."
        return 0
    fi

    echo ".env file found"
    return 0
}

check_disk_space() {
    echo ""
    echo "Disk Space:"
    df -h /
    echo ""
}

check_docker_access() {
    if ! docker ps > /dev/null
    then
        echo "Current user does not have access to Docker"
        return 1
    fi

    echo "Docker access verified"
    return 0
}

main() {
    print_header

    if ! validate_environment "$environment"
    then
        exit 1
    fi

    if ! check_docker_available
    then
        exit 1
    fi

    if ! check_compose_file
    then
        exit 1
    fi

    check_env_file
    check_disk_space

    if ! check_docker_access
    then
        exit 1
    fi

    echo "Deployment precheck completed successfully"
}

main