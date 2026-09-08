# Plugin management

This document covers the managed plugin lifecycle for the shell runtime.

## Source of truth

The plugin repo list is managed in [../../plugins/git_repos.txt](../../plugins/git_repos.txt).

## Main command

```bash
zsh_plugins --install
zsh_plugins --update
zsh_plugins --check-forks --dry-run
```

## What the plugin manager does

- installs missing plugin checkouts
- updates the managed repo set in a controlled way
- checks whether a fork is missing or behind its upstream remote
- supports dry-run previews before making changes

## Recommended workflow

```bash
source ~/.zshrc
zsh_plugins --check-forks --dry-run
zsh_plugins --install
```

This keeps the plugin set reviewable and helps catch drift before it becomes a runtime problem.

## Description

The plugin system is intentionally explicit. It favors reproducibility and observability over surprise changes so the shell feature set remains stable and easy to audit.
