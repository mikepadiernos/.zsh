# Docker module

This document covers the Docker runtime helper in [modules/.zsh_docker](../../modules/.zsh_docker).

## Purpose

The Docker module makes local container workflows quieter and easier to manage. It checks whether Docker is available, can connect to a Colima-managed daemon, and exposes shorthand aliases for common Docker and Compose commands.

## Main behavior

- verifies Docker availability and falls back to Colima when configured
- optionally auto-starts a Colima profile when `ZSH_DOCKER_AUTO_START=true`
- switches the Docker context to the configured Colima context when needed
- wraps Docker commands with runtime checks so the shell does not fail noisily when the daemon is unavailable
- defines helper commands such as `docker_runtime`, `dkr`, `dco`, `dcp`, and common `d-*` aliases like `d`, `dkb`, `d-alpine`, and `d-ubuntu`

## Idea behind the module

This module is designed to remove repetitive Docker friction: the developer can just use the normal command names while the shell ensures the runtime is ready in the right context. It is especially helpful on macOS and local Linux workstations where Docker Desktop or Colima is used as the underlying engine.

## Recommended workflow

```bash
source ~/.zshrc
export ZSH_DOCKER_AUTO_START=true
Docker_runtime

dco up

dkr
```

Useful daily patterns are to confirm the Docker runtime, bring up compose stacks with `dco`, and use the short aliases for quick image and container operations.

## Setup

```bash
# install Docker or Colima, then load the runtime
export ZSH_DOCKER_AUTO_START=true
export ZSH_DOCKER_CONTEXT_NAME=colima
export ZSH_DOCKER_COLIMA_PROFILE=default
source ~/.zshrc

docker_runtime
```

The module is best used with either a normal Docker daemon or a Colima-backed context. Once the runtime is healthy, the aliases and wrappers keep the developer experience lightweight without forcing constant manual environment checks.
