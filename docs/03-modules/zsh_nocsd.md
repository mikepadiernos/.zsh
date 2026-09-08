# GTK no-csd module

This document covers the GTK no-csd helper in [modules/.zsh_nocsd](../../modules/.zsh_nocsd).

## Purpose

The GTK no-csd module helps with applications that are affected by the GTK client-side decorations library. It sets an environment override so the shell can bypass the library when it is known to cause issues and maintain a stable desktop UX.

## Main behavior

- looks for the `gtk-nocsd` library on standard system paths
- prepends the library to `LD_PRELOAD` when a GUI session is active
- identifies commands that should bypass the preload to avoid broken behavior in certain apps
- reads a blacklist file from `$XDG_CONFIG_HOME/gtk-nocsd-blacklist` and creates `env -u LD_PRELOAD` aliases for those commands
- restores `LD_PRELOAD` after each command so the effect is scoped to the relevant invocation

## Idea behind the module

This is a targeted compatibility shim. It solves one known problem — GTK client-side decorations interfering with some apps — without forcing a global environment change for every program in the session.

## Recommended workflow

```bash
# install gtk-nocsd if needed
source ~/.zshrc

# add any applications that should be excluded from preload to ~/.config/gtk-nocsd-blacklist
```

The blacklist is the key to keeping the workaround safe: only the commands that really need to bypass the library get the override.

## Setup

```bash
mkdir -p ~/.config
cat > ~/.config/gtk-nocsd-blacklist <<'EOF'
# add apps that should bypass GTK no-csd here
spotify
code
EOF
source ~/.zshrc
```

This makes the module behave as a scoped compatibility layer rather than a broad global patch, which is the safest option for interactive desktop use.
