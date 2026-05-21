#!/bin/bash

set -e
set -u
set -o pipefail

show_disk_usage() {

    echo "Checking Docker disk usage..."
    docker system df
}

cleanup_stopped_containers() {

    echo "Removing stopped containers"
    docker container prune -f
}

cleanup_unused_images() {
    
    echo "Removing unused images"
    docker image prune -f
}

cleanup_unused_networks() {
    
    echo "Removing unused networks"
    docker network prune -f
}

main() {

    echo "Starting Docker Cleanup"

    show_disk_usage
    cleanup_stopped_containers
    cleanup_unused_images
    cleanup_unused_networks
    show_disk_usage
    
    echo "Cleanup completed"
}

main