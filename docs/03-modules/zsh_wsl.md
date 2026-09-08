# WSL module

This document covers the Windows Subsystem for Linux helper in [modules/.zsh_wsl](../../modules/.zsh_wsl).

## Purpose

The WSL module recognizes when the shell is running inside WSL and then enables clipboard helpers that match the Linux environment. It makes the shell feel more native while still bridging to the Windows clipboard when needed.

## Main behavior

- detects whether the current environment is WSL by checking `/proc/sys/kernel/osrelease`
- enables clipboard aliases `copy` and `paste` when `pbcopy`/`pbpaste` are available
- otherwise falls back to Windows clipboard tools such as `clip.exe` and `powershell.exe`
- binds `Ctrl+V` to a paste widget in interactive shells when the clipboard backend is active

## Idea behind the module

This is a small but valuable WSL integration layer. The goal is to make cross-environment clipboard interactions feel seamless without adding unnecessary complexity to the shell runtime.

## Recommended workflow

```bash
source ~/.zshrc
printf 'hello from WSL\n' | copy
paste
```

This is the usual pattern for copying text between the Linux shell and the host Windows environment.

## Setup

```bash
# nothing special is required beyond running in WSL
source ~/.zshrc
```

Once the environment is detected as WSL, the module automatically adds the clipboard integration and the paste widget to the interactive shell.
