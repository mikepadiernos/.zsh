---
description: "Use when editing plugin loader logic and plugin manifests. Enforce plugin order, dependency strategy, and quiet startup behavior."
applyTo: "configs/.zsh_plugins"
---

## Plugin order and dependencies
- Keep zsh-job-queue available before zsh-abbr.
- Preserve compatibility path resolution for zsh-abbr dependency files.

## Dependency install strategy
- Keep startup dependency auto-install opt-in.
- Installer priority: mise first.
- Only if mise has no matching package, allow brew for non-root users.
- Never use brew fallback as root.

## Output hygiene
- Avoid startup noise by default.
- Emit diagnostic output only behind explicit debug flags.
