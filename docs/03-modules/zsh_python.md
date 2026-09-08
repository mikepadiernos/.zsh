# Python module

This document covers the Python auto-venv helper in [modules/.zsh_python](../../modules/.zsh_python).

## Purpose

The Python module detects project-local virtual environments and can activate them automatically when the shell changes directories.

This helper is the canonical Python activation guide and replaces the earlier brief standalone Python summary that was duplicated elsewhere in the docs tree.

## Main behavior

- looks upward for a `.venv` folder in the current directory tree
- deactivates any existing virtualenv before switching
- sources the project environment when it is found
- exposes `zsh_python` with status and toggling options
- supports opt-in or opt-out of automatic activation via `ZSH_PYTHON_AUTO_VENV`

## Idea behind the module

This is a lightweight convenience layer for Python projects. It keeps the shell environment clean while still helping developers move into the correct project virtualenv without extra manual work.

## Recommended workflow

```bash
source ~/.zshrc
cd ~/project
zsh_python --status
```

If the project has a `.venv`, the shell should activate it automatically during prompt refresh or directory changes.

## Setup

```bash
cd ~/project
python -m venv .venv
source ~/.zshrc
```

Once the virtualenv is present, the shell will discover it and activate it automatically. You can disable the behavior temporarily with `zsh_python --disable-auto-venv` or re-enable it with `zsh_python --enable-auto-venv`.
