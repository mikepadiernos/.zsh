---
description: "Use when editing plugin repository lists and plugin subtree contents under plugins/. Keep manifest entries consistent and startup-safe."
applyTo: "plugins/**"
---

## Plugin manifest hygiene
- Keep plugin repo entries unique and canonical.
- Prefer deterministic plugin source paths.
- Avoid changes that trigger noisy startup install loops.

## Compatibility rules
- Keep zsh-abbr and zsh-job-queue integration intact.
- Preserve assumptions used by configs/.zsh_plugins loader.
