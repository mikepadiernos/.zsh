# Setup configuration

This document covers the shell setup helper defined in `.zsh/configs/.zsh_setup`.

## Purpose

The setup configuration helps create a ready-to-use local runtime for a fresh machine or a fresh clone. It handles:

- local Python virtualenv creation
- repo list cloning
- bootstrap of `mise` when needed
- installation of tooling via the `tools` command
- plugin installation when available
- symlink setup for config directories

## Main functions

The file defines:

- `_zsh_setup_venv` — create or refresh a local `.venv`
- `_zsh_setup_pull_repos` — clone repositories from a repo list
- `_zsh_setup_bootstrap_mise` — install `mise` when it is missing
- `_zsh_setup_install_tooling` — install tooling via `tools --update --mise-only`
- `_zsh_setup_all` — full bootstrap flow
- `zsh_setup` — public command wrapper

## Public command

```bash
zsh_setup --setup-all [path/to/git_repos.txt] [python-executable]
zsh_setup --setup-venv [python-executable]
zsh_setup --pull-repos [path/to/git_repos.txt]
zsh_setup --help
```

## Step-by-step guidance

### 1. Create the local Python environment

```bash
zsh_setup --setup-venv python3
```

This creates `.venv` in the current project directory, upgrades pip, and installs `PyNaCl` for repo-local support.

### 2. Pull a repository list

```bash
zsh_setup --pull-repos ./git_repos.txt
```

This clones each repository line from the provided list into the same folder as the manifest.

### 3. Run a full setup

```bash
zsh_setup --setup-all
```

This performs all steps in order:

1. clone repos from the list
2. create/update `.venv`
3. bootstrap `mise` when missing
4. install tooling via `tools --update --mise-only`
5. install zsh plugins via `zsh_plugins --install`
6. apply symlink setup via `tools --setup-links`

### 4. Run a dry/preview pass

The helper itself is not dry-run aware, but the underlying `tools` and `zsh_plugins` layers support preview flow. A common safe pattern is:

```bash
tools --update --dry-run
zsh_plugins --check-forks --dry-run
```

## Recommended workflow

For a fresh clone or machine bootstrap:

```bash
cd ~/.zsh
zsh_plugins --install
source ~/.zshrc
zsh_setup --setup-all
zsh_health
```

This sequence gets the shell environment into a working state and then verifies the current repo health before deeper maintenance.

## Troubleshooting

If setup fails:

- verify `python3` exists and is executable
- verify that `curl` is installed for `mise` bootstrap
- rerun `source ~/.zshrc` before invoking the tooling wrapper
- check whether `tools` is available in the shell session

## Description

The setup helper exists to reduce the cost of a fresh environment. It automates the boring but common steps that happen during a first shell setup: repo checkout, local Python environment creation, tool bootstrap, plugin install, and link setup.
