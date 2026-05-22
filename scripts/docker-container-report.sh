#!/bin/bash

set -e
set -u
set -o pipefail

print_header() {
    echo "Docker container Report"
    echo "-----------------------"
}

check_docker_available() {
    
    if ! command -v docker > /dev/null 2>&1
    then
        echo "Docker is not installed or not available in path"
        return 1
    fi

    return 0
}

show_container_report() {
    docker ps -a --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

main() {

    print_header
    
    if ! check_docker_available
    then
        exit 1
    fi

    show_container_report

    echo "Docker Report successfully completed"
}

main