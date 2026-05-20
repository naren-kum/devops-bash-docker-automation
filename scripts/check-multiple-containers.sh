#!/bin/bash

set -e
set -u
set -o pipefail

echo "Starting container health check"

running_count=0
not_running_count=0

check_container() {
    local container_name=$1

    if docker ps --format '{{.Names}}' | grep -qx "$container_name"
    then
        echo "$container_name is running"
        return 0
    else
        echo "$container_name is not running"
        return 1
    fi
}


for container in test-nginx postgres redis
do
	if check_container "$container"
	then
		running_count=$((running_count + 1))
	else
		not_running_count=$((not_running_count + 1))
	fi
done

echo "Summary:"
echo "Running containers: $running_count"
echo "Not running containers: $not_running_count"

if [ "$not_running_count" -gt 0 ]
then
	echo "Container Health check failed"
	exit 1
else
	echo "Container Health check passed"
	exit 0
fi




