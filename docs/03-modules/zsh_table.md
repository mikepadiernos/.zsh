# Table module

This document covers the rich table and directory listing helper in [modules/.zsh_table](../../modules/.zsh_table).

## Purpose

The table module improves the shell’s directory and file presentation by generating a more readable listing with metadata such as size, permissions, owner, group, dates, and symlink information. It creates a wrapper `lll` command that behaves like a friendlier `ls` for interactive use.

## Main behavior

- ensures a local `lll` helper exists under `$HOME/.local/bin`
- sources the table logic if it is not already available
- renders a structured table view with metadata columns for files and directories
- supports different styles such as encoded or Unicode box formatting
- uses human-readable sizes and formatted timestamps
- preserves standard `ls`-style output when the helper is not needed

## Idea behind the module

This module exists to make shell output easier to scan, especially when browsing projects with lots of files. It turns the default directory listing into a more information-dense view without breaking the normal shell experience.

## Recommended workflow

```bash
source ~/.zshrc
lll
lll ~/
lll -a .
```

This is especially helpful in project directories where the developer wants a better read on permissions, sizes, timestamps, and ownership at a glance.

## Setup

```bash
source ~/.zshrc
lll --help
```

The helper is automatically installed into `~/.local/bin` the first time it is invoked and added to `PATH` so it behaves like a normal shell utility.
