# Composer module

This document covers the Composer detection helper in [modules/.zsh_composer](../../modules/.zsh_composer).

## Purpose

The Composer module provides a simple runtime notice when a PHP project is present and Composer is in use. It is intentionally lightweight: it highlights project context without changing the shell workflow.

## Main behavior

- checks for a `composer.json` file in the current directory
- logs a status message when Composer is active in the project root
- logs a message when Composer itself is installed but no project file is active
- stays quiet if Composer is not present and there is no project context

## Idea behind the module

This module is a convenience layer, not a full PHP toolchain. It tells the user that the current project is Composer-based and that the shell is ready for PHP tooling without forcing a heavy startup cost.

## Recommended workflow

```bash
cd ~/project
composer --version
composer install
composer update
```

When a local project has a `composer.json`, the shell will announce that context and the developer can proceed with the normal PHP workflow.

## Setup

```bash
# install Composer if needed
curl -sS https://getcomposer.org/installer | php
mv composer.phar ~/.local/bin/composer

# then use it in a project
cd ~/project
composer install
```

The module assumes Composer is either already installed or added to `PATH` so the shell can detect it cleanly during startup.
