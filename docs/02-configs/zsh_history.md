# History configuration

This document covers the behavior defined in `.zsh/configs/.zsh_history`.

## Purpose

The history setup controls zsh session history persistence and search behavior. It is responsible for:

- storing history into a stable history file
- keeping history size high enough for daily workflow
- de-duping events while preserving useful history
- enabling incremental reverse-search shortcuts

## Main behaviors

The file configures:

- `HIST_STAMPS="yyyy.mm.dd"` to timestamp commands
- `HISTFILE="$HOME/.temp/zsh/zsh_history"` as the runtime history path
- `HISTSIZE=5000000` and `SAVEHIST=$HISTSIZE`
- `EXTENDED_HISTORY` to record start time and elapsed time
- `HIST_EXPIRE_DUPS_FIRST`
- `HIST_FIND_NO_DUPS`
- `HIST_IGNORE_ALL_DUPS`
- `HIST_IGNORE_DUPS`
- `HIST_IGNORE_SPACE`
- `HIST_SAVE_NO_DUPS`
- `SHARE_HISTORY` to share the command history across active sessions

It also binds:

- `Ctrl+R` → `history-incremental-search-backward`
- `Ctrl+S` → `history-incremental-search-forward`

## How it works

On shell startup, the history config does the following:

1. checks whether Atuin history integration is active
2. if not, configures the local temp history path and history settings
3. ensures the temp directory exists
4. enables deduplication and sharing options
5. installs the reverse-search bindings for terminal recall

## Typical usage

To inspect the active history settings:

```bash
echo "$HISTFILE"
print -r -- "$HISTSIZE"
setopt | grep HIST
```

To search history interactively:

- press `Ctrl+R` to reverse-search your command history
- press `Ctrl+S` to search forward if enabled in your terminal

## Step-by-step guidance

### 1. Ensure the history directory exists

```bash
mkdir -p ~/.temp/zsh
```

### 2. Check the active file path

```bash
echo "$HISTFILE"
```

### 3. Test history persistence

```bash
echo test-history-$(date +%s) >> ~/.temp/zsh/zsh_history
history | tail -n 10
```

### 4. Ensure shell history-sharing is active

```bash
setopt | grep SHARE_HISTORY
```

## Recommended workflow

For a standard session:

```bash
source ~/.zshrc
history | tail -n 20
```

This confirms that the session has history enabled and that the runtime is using the expected file and retention behavior.

## Troubleshooting

If history is missing or stale:

- check whether `HISTFILE` is set correctly
- confirm the `.temp/zsh` directory exists
- verify that `SHARE_HISTORY` and the deduplication settings are active
- check whether Atuin configuration is overriding the default history path

## Description

History is a quiet but important part of the shell runtime. It preserves command continuity across sessions and gives the shell a helpful, low-friction way to recover previous work without adding complexity or startup noise.
