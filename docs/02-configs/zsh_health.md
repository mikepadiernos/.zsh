# Project health report

The project health report is provided by configs/.zsh_health and is loaded during normal shell startup.

## Command

```bash
zsh_health
zsh-health
```

## What it shows

The report clears the terminal and prints a quick dashboard with:

- system metadata
- current project type
- environment status (native, WSL, or VPS)
- Docker status
- DDEV status when configured
- Drupal status when detected

## Project detection

The command tries to infer the project type from common repo markers, including:

- drupal + ddev
- ddev
- drupal
- wordpress
- nextcloud
- next.js
- react
- node
- python
- php
- docker-compose
- git project
- generic repo fallback

## Environment detection

It reports:

- WSL when WSL-specific markers are detected
- VPS when SSH/systemd context indicates a remote or server environment
- native otherwise

## Example output

```text
Project health report

System
  Project            /home/user/project
  Type               drupal + ddev
  OS                 Linux 6.8.0-52-generic (x86_64)
  Shell              /usr/bin/zsh
  User               user
  Disk               42G/128G used, 80G avail
  Git                main
  Git state          ## main...origin/main
  Environment        WSL

Docker
  Docker             available
  Context            default
  Containers         2

Health check complete
Project type: drupal + ddev
```

## Default workflow

Run this when you want a quick sanity check on the current project:

```bash
cd ~/project
zsh_health
```

This is the shortest path to seeing whether the environment, Docker, and project type look healthy before you start deeper work.

## Description

The health report is meant to be a lightweight terminal dashboard for day-to-day diagnostics. It is tuned for readability and speed, not for full CI-level validation, which is why it keeps output focused on the current directory and the environment around it.
