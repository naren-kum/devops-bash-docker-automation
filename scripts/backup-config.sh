#!/bin/bash

set -e
set -u
set -o pipefail

source_dir="${1:-}"

if [ -z "$source_dir" ]
then
    echo "Usage: ./scripts/backup-config.sh <folder-path>"
    exit 1
fi

check_folder_exist() {
    local source_dir=$1

    if [ ! -d "$source_dir" ]
    then
        return 1
    fi

    echo "Source folder found: $source_dir. Going to the next step"
    return 0
}

check_create_backup_folder() {
    if [ ! -d "backups" ]
    then
        echo "backups folder not found. Creating one"
        mkdir -p backups
    else
        echo "backups folder exists. Going to the next step"
    fi
}

create_backup() {
    local source_dir=$1
    local timestamp
    local backup_name
    local backup_path

    timestamp=$(date "+%Y-%m-%d-%H-%M-%S")
    backup_name="$(basename "$source_dir")-$timestamp"
    backup_path="backups/$backup_name"

    echo "Creating backup now"
    cp -r "$source_dir" "$backup_path"

    echo "Backup completed for $source_dir"
}

echo "Starting backup"

if ! check_folder_exist "$source_dir"
then
	echo "Source folder not found"
	exit 1
else
	echo "Source folder found. Going to the next step"
fi

check_create_backup_folder

create_backup "$source_dir"

