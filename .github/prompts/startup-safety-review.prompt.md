---
mode: "agent"
description: "Review recent changes for zsh startup safety and remove prompts/noise regressions."
---

Review this repository for startup-time regressions and propose or apply fixes.

Focus areas:
- configs/.zsh_bootstrap
- configs/.zsh_plugins
- configs/.zsh_completions
- configs/.zsh_history
- modules/.zsh_homebrew

Checks:
1. No interactive prompts during startup.
2. No command-not-found output.
3. No noisy failed-install output unless explicitly enabled.
4. Dependency install behavior remains opt-in.
5. Plugin ordering keeps zsh-job-queue available before zsh-abbr.

When editing code:
- Preserve existing behavior unless change is required for startup reliability.
- Validate syntax for edited zsh files.
- Summarize findings by severity first, then change summary.
