# DevOps Bash Docker Automation

This repository contains Bash scripts for automating common DevOps, Docker, Linux, and deployment-precheck tasks.

The goal of this project is to demonstrate practical Bash scripting for DevOps workflows such as Docker Compose management, container health checks, backups, log scanning, Docker cleanup, system health checks, and deployment validation.

---

## Repository Structure

```text
devops-bash-docker-automation/
├── docker-compose.yml
├── README.md
├── .gitignore
└── scripts/
    ├── manage-environment.sh
    ├── check-multiple-containers.sh
    ├── backup-config.sh
    ├── log-error-checker.sh
    ├── docker-cleanup.sh
    ├── docker-container-report.sh
    ├── system-health-check.sh
    └── deployment-precheck.sh

Scripts
1. manage-environment.sh

Interactive Bash script to manage Docker Compose services for different environments.

Supported environments
dev
qa
staging
prod
Supported actions
start
stop
restart
status
Features
Environment validation
Action validation
Docker Compose file validation
Docker Compose start, stop, restart, and status operations
Timestamped logging
Safe exit codes for CI/CD usage
Uses safe Bash options: set -e, set -u, and set -o pipefail
Usage
chmod +x scripts/manage-environment.sh
./scripts/manage-environment.sh
Example
Select the environment: dev
Selected environment: dev
Select the action (start/stop/restart/status): status
Selected action: status
_____Checking for docker compose file_____
2026-05-20 12:29:49 - docker-compose.yml found
2026-05-20 12:29:49 - Checking status for dev environment
2026-05-20 12:29:49 - Action completed successfully
2. check-multiple-containers.sh

Checks whether expected Docker containers are running.

Features
Checks multiple Docker container names
Uses a reusable check_container function
Counts running and not-running containers
Prints a summary
Exits with failure if any expected container is not running
Usage
chmod +x scripts/check-multiple-containers.sh
./scripts/check-multiple-containers.sh
Example output
Starting container health check
test-nginx is running
postgres is not running
redis is not running

Summary:
Running containers: 1
Not running containers: 2
Container health check failed
3. backup-config.sh

Creates timestamped backups of a given source folder.

Features
Validates input argument
Checks source folder exists
Creates backups/ folder if missing
Creates timestamped backup directory
Copies source folder into backups/
Uses safe Bash options and exit codes
Usage
chmod +x scripts/backup-config.sh
./scripts/backup-config.sh ./config
Example output
Starting backup
Source folder found: ./config
Source folder found. Going to the next step
backups folder exists. Going to the next step
Creating backup now
Backup completed for ./config
Backup location: backups/config-2026-05-20-18-28-13
4. log-error-checker.sh

Checks a log file for error messages and fails if errors are found.

Features
Accepts log file path as input
Validates log file exists
Searches for error case-insensitively
Counts error lines
Exits with failure if errors are found
Useful for CI/CD log validation and operational checks
Usage
chmod +x scripts/log-error-checker.sh
./scripts/log-error-checker.sh logs/app.log
Example output when errors are found
Starting log error check
Log file found: logs/app.log
Error count: 2
Errors found in log file
Example output when no errors are found
Starting log error check
Log file found: logs/clean.log
Error count: 0
No errors found in log file
Log check completed successfully
5. docker-cleanup.sh

Safely cleans unused Docker resources.

Features
Shows Docker disk usage before cleanup
Removes stopped containers
Removes unused Docker images
Removes unused Docker networks
Shows Docker disk usage after cleanup
Avoids aggressive cleanup such as volume pruning or docker image prune -a
Usage
chmod +x scripts/docker-cleanup.sh
./scripts/docker-cleanup.sh
Example output
Starting Docker cleanup
Checking Docker disk usage...
Removing stopped containers
Removing unused images
Removing unused networks
Checking Docker disk usage...
Docker cleanup completed successfully
6. docker-container-report.sh

Generates a simple Docker container inventory report.

Features
Checks whether Docker is available
Lists all containers, including stopped containers
Displays container name, image, status, and ports
Useful for quick server/container visibility
Usage
chmod +x scripts/docker-container-report.sh
./scripts/docker-container-report.sh
Example output
Docker Container Report
-----------------------
NAMES              IMAGE          STATUS          PORTS
test-nginx         nginx:latest   Up 2 hours      0.0.0.0:8080->80/tcp
confident_rhodes   nginx          Up 3 days       80/tcp

Docker report successfully completed
7. system-health-check.sh

Performs a basic Linux system health check.

Features
Shows CPU load
Shows memory usage
Shows disk usage for root filesystem
Checks Docker availability
Counts running Docker containers
Continues gracefully if Docker is unavailable
Usage
chmod +x scripts/system-health-check.sh
./scripts/system-health-check.sh
Example output
System Health Check
-------------------

CPU Load:
 12:10:21 up 2 days, load average: 0.08, 0.04, 0.01

Memory Usage:
              total        used        free
Mem:           7.6Gi       2.1Gi       4.8Gi

Disk Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdc        251G   12G  227G   5% /

Docker Status:
Docker is available
Docker version 28.3.3, build 980b856
Running Docker Containers: 2

System health check completed
8. deployment-precheck.sh

Runs pre-deployment checks before starting deployment activities.

Features
Accepts environment name as an argument
Validates supported environment
Checks Docker availability
Checks docker-compose.yml exists
Checks optional .env file and warns if missing
Shows disk usage
Verifies Docker access
Separates hard checks from soft warnings
Supported environments
dev
qa
staging
prod
Usage
chmod +x scripts/deployment-precheck.sh
./scripts/deployment-precheck.sh dev
Example output
Deployment Precheck
-------------------
Environment: dev

Docker is available
docker-compose.yml found
WARNING: .env file not found. Continuing because it is optional for this lab.

Disk Space:
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdc        251G   12G  227G   5% /

Docker access verified
Deployment precheck completed successfully
Docker Compose Test Service

The included docker-compose.yml runs a simple Nginx container for local testing.

Start test service
docker compose up -d
Check status
docker compose ps
Stop test service
docker compose down
Git Ignore

Generated files, logs, local environment files, and test folders are ignored.

*.log
.env
backups/
config/
logs/
Key Bash Concepts Demonstrated

This project demonstrates:

Bash variables
Script arguments
Input validation
if/else conditions
case statements
Functions
Local variables
Return codes
Exit codes
File checks using -f
Directory checks using -d
Empty variable checks using -z
Safe Bash settings:
set -e
set -u
set -o pipefail
Docker command automation
Docker Compose operations
Log scanning using grep
Timestamped backups
Git feature branch workflow
Pull requests and release tagging
Release History
Version	Description
v0.1.0	Added Docker Compose environment manager
v0.2.0	Added multiple container health check script
v0.3.0	Added config backup script
v0.4.0	Updated README documentation
v0.5.0	Added log error checker script
v0.6.0	Added Docker cleanup script
v0.7.0	Added Docker container report script
v0.8.0	Added system health check script
v0.9.0	Added deployment precheck script
v1.0.0	Completed Bash Docker automation portfolio project
Purpose of This Project

This project was created as part of a DevOps learning and portfolio-building journey.

It demonstrates practical Bash scripting for common DevOps tasks such as:

Validating deployment prerequisites
Managing Docker Compose services
Checking container health
Creating backups
Scanning logs for errors
Cleaning Docker resources
Reporting container status
Checking Linux system health
Performing deployment prechecks