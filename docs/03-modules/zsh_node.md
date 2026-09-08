# Node module

This document covers the lazy Node/NVM helper in [modules/.zsh_node](../../modules/.zsh_node).

## Purpose

The Node module detects Node-based projects and loads NVM only when it is actually needed. It also supports `mise`-managed Node toolchains, which lets the shell remain fast and predictable.

This helper is the canonical implementation for the lazy Node/NVM workflow and replaces the older standalone Node summary that was previously kept in a dedicated module page.

## Main behavior

- scans upward from the current directory to find a project root with `package.json`, `.nvmrc`, or `.node-version`
- detects whether the project is actually using Node and whether the Node version should be managed by NVM or `mise`
- loads `nvm.sh` lazily instead of at shell startup
- avoids repeated status work with small refresh debouncing
- logs state when a project uses Node or a `mise`-managed Node config

## Idea behind the module

This is a low-noise Node environment helper. It delays activation until the current directory clearly needs it, which keeps shell startup fast and avoids unnecessary environment churn.

## Recommended workflow

```bash
source ~/.zshrc
cd ~/project-with-node
node -v
npm -v
```

The module is meant to be transparent: if you are not in a Node project, nothing disruptive happens; when you are, the shell loads the expected tooling automatically.

## Setup

```bash
# standard Node project
cd ~/project
printf 'lts/*\n' > .nvmrc
source ~/.zshrc

# or rely on mise-managed Node versions
cat > .mise.toml <<'EOF'
[tools]
node = 'lts'
EOF
source ~/.zshrc
```

The key idea is to let the environment remain lazy and only activate when the project declares Node usage.
