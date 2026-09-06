---
description: "Use when editing the root .zshrc entrypoint. Preserve canonical runtime paths and bootstrap handoff behavior."
applyTo: ".zshrc"
---

## Entrypoint policy
- Keep runtime path variables aligned to ~/.zsh.
- Keep FILES pointed to ~/.files for app-config links.
- Preserve bootstrap sourcing and avoid direct duplication of config/module logic.

## Safety
- Keep initialization non-interactive by default.
- Avoid adding expensive network or install actions directly in .zshrc.
