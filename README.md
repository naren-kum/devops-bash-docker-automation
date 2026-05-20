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
