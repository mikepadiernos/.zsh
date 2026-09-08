# Homebrew module

This document covers the Homebrew integration in [modules/.zsh_homebrew](../../modules/.zsh_homebrew).

## Purpose

The Homebrew module ensures the shell sees the correct Homebrew environment when it is installed, while avoiding unsafe behavior for root shells. It also helps ensure PHP from Homebrew is placed on the correct `PATH` and that brew-based upgrades can work with the expected environment flags.

## Main behavior

- disables Homebrew behavior in root shells
- looks for standard Homebrew install locations on Linux and macOS
- loads `brew shellenv` when available
- adds `mysql-client` bin paths when the formula is installed
- applies a safe compatibility override for `brew upgrade --force-bottle`
- appends Homebrew-managed PHP include and library paths when a PHP formula is active

## Idea behind the module

This module treats Homebrew as a toolchain integration, not a mandatory OS-level dependency. It attempts to make the shell environment predictable without reintroducing startup noise or unsafe root assumptions.

## Recommended workflow

```bash
source ~/.zshrc
brew --version
php -v
```

When Homebrew is available, the shell imports the expected environment and keeps the local package toolchain usable without extra manual PATH setup.

## Setup

```bash
# install Homebrew or ensure it is already available
source ~/.zshrc

# optional: point to a specific PHP formula if needed
export HOMEBREW_PHP_FORMULA="php@8.4"
source ~/.zshrc
```

The module is intentionally conservative: it only activates the Homebrew environment when the install is present and the user is not root.
