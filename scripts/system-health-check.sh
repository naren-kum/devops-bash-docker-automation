#!/bin/bash

set -e
set -u
set -o pipefail

print_header() {
    echo "System Health Check"
    echo "-------------------"
    echo ""
}

check_cpu_load() {
    echo "CPU Load:"
    uptime
    echo ""
}

check_memory_usage() {
    echo "Memory Usage:"
    free -h
    echo ""
}

check_disk_usage() {
    echo "Disk Usage:"
    df -h /
    echo ""
}

check_docker_status() {
    echo "Docker Status:"

    if ! command -v docker > /dev/null 2>&1
    then
        echo "Docker is not available"
        return 1
    fi

    echo "Docker is available"
    docker --version
    return 0
}

check_running_containers() {
    echo "Running Docker Containers: $(docker ps -q | wc -l)"
    echo ""
}

main() {
    print_header
    check_cpu_load
    check_memory_usage
    check_disk_usage

    if check_docker_status
    then
        check_running_containers
    else
        echo "Skipping Docker container check"
        echo ""
    fi

    echo "System health check completed"
}

main