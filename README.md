# DevOps Bash Docker Automation

This repository contains Bash scripts for automating common DevOps and Docker Compose operations.

## Scripts

### manage-environment.sh

Interactive Bash script to manage Docker Compose services for different environments.

Supported environments:

- dev
- qa
- staging
- prod

Supported actions:

- start
- stop
- restart
- status

## Features

- Environment validation
- Action validation
- Docker Compose file validation
- Docker Compose start/stop/restart/status operations
- Logging with timestamps
- Safe exit codes for CI/CD usage

## Usage

```bash
chmod +x scripts/manage-environment.sh
./scripts/manage-environment.sh


### check-multiple-containers.sh

Checks whether expected Docker containers are running.

## Features

- Checks multiple container names
- Uses a reusable function
- Counts running and not-running containers
- Fails if any expected container is not running

## Usage
./scripts/check-multiple-containers.sh


### backup-config.sh

Creates timestamped backups of a given source folder.

## Features

- Validates input argument
- Checks source folder exists
- Creates backups folder if missing
- Creates timestamped backup directory
- Copies source folder into backups/
- Uses safe Bash options and exit codes

## Usage

./scripts/backup-config.sh ./config

### Git Ignore

*.log
.env
backups/
config/

### Release History

Version	Description
v0.1.0	Added Docker Compose environment manager
v0.2.0	Added multiple container health check script
v0.3.0	Added config backup script
