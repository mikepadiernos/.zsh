# Drush module

This document covers the DDEV-aware Drush helper in [modules/.zsh_drush](../../modules/.zsh_drush).

## Purpose

The Drush module is a convenience layer for Drupal development in DDEV-managed projects. It detects whether the current directory is inside a DDEV project and then loads helper commands for common Drush tasks.

## Main behavior

- checks whether `.ddev/config.yaml` exists in the current project
- loads Drupal helper functions when the project is a DDEV environment
- provides wrappers such as `den`, `dun`, `dcr`, `dcri`, and `dcrx`
- unloads those functions when the shell leaves a DDEV project

## Idea behind the module

This avoids the need to type `ddev drush` repeatedly. The module keeps Drush commands available only when they fit the current project context, so the shell stays clean and the workflow stays obvious.

## Recommended workflow

```bash
cd ~/drupal-project
ddev start

den some_module

dcr
```

The common pattern is to use the project’s DDEV environment and then rely on the shell helpers for enabling, disabling, and clearing caches.

## Setup

```bash
ddev config --project-type=drupal
cd ~/drupal-project
ddev start
source ~/.zshrc
```

The helper is automatically activated when the project directory contains `.ddev/config.yaml`. After that, the shell exposes the short Drush wrappers without additional manual configuration.
