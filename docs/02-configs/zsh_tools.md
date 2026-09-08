# Tooling configuration

This document covers the shell tooling orchestration defined in `.zsh/configs/.zsh_tools`.

## Purpose

The tooling layer manages the update and link flows for the shell environment. It provides:

- app and tool install checks
- symlink setup from `~/.files` into the home directory
- `tools --update` orchestration for package updates
- `zsh_plugins` integration for plugin maintenance
- safe handling of optional dependencies and missing applications

## Main concepts

### 1. `tools --update`

This command is the primary update orchestrator. It is designed to handle the package, app, and config update process while respecting the runtime context.

Typical usage:

```bash
tools --update
tools --update --dry-run
tools --update --mise-only
tools --update --no-brew
```

### 2. Symlink management

The tooling layer maintains links from `~/.files` into the home directory, including common app config directories such as:

- `.config/Code/User`
- `.config/atuin`
- `.config/yazi`
- `.config/lazygit`
- `.config/lazydocker`
- `.config/qutebrowser`
- `.local/bin` shims for app helpers

It also preserves backups when a target already exists.

### 3. App gating

The tooling flow can skip app setup when required executables are missing. This keeps startup and update actions safe and context-aware.

## Common commands

```bash
tools --list-tools
tools --list-links
tools --setup-links
tools --setup-links --dry-run
```

## Step-by-step guidance

### 1. Preview the tool update plan

```bash
tools --update --dry-run
```

This shows what the update path would do without executing it.

### 2. Install or relink config entries

```bash
tools --setup-links
```

This synchronizes the expected files from `~/.files` into the real home directory.

### 3. Check which app mappings are expected

```bash
tools --list-links
```

This helps identify the symlink map and confirm which files are managed by the runtime.

### 4. Run a scoped update

```bash
tools --update --mise-only
```

This only installs or updates the `mise`-managed toolchain subset when needed.

## Recommended workflow

For a normal maintenance cycle:

```bash
tools --list-links
tools --setup-links --dry-run
tools --update --dry-run
```

Then apply the real run only after previewing the changes:

```bash
tools --setup-links
tools --update
```

## Troubleshooting

If the update path behaves unexpectedly:

- check whether the required app is installed
- preview the link setup before applying it
- verify the `~/.files` root exists and contains the expected layout
- confirm that the current shell has the path and environment variables needed by the affected tool

## Description

The tooling configuration is the maintenance layer between the repo and the developer machine. It tries to keep updates and config synchronization deliberate, visible, and reversible rather than hidden inside shell startup behavior.
