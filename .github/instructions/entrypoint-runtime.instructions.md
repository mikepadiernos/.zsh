---
description: "Use when editing root startup entrypoints and load order files. Preserve runtime paths and deterministic module/config ordering."
applyTo: "configs/.zsh_*"
---

## Runtime invariants
- Keep zsh runtime rooted at ~/.zsh.
- Keep app config source rooted at ~/.files.
- Do not add runtime dependency on ~/.files/.zsh/.zshrc.

## Load-order invariants
- Preserve deterministic module and config load order.
- Keep startup behavior non-interactive and quiet by default.
- Avoid heavy network/package operations during startup unless explicitly opt-in.
