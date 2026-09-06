---
description: "Use when editing zsh startup config files under configs/. Enforce strict non-interactive startup behavior and compatibility with VPS/non-root environments."
applyTo: "configs/**"
---

## Startup strict mode
- Reject changes that introduce interactive prompts during init.
- Reject changes that add noisy failures or install chatter at startup.
- Prefer silent fallbacks and explicit opt-in flags for expensive operations.

## Safety expectations
- Preserve compinit non-interactive behavior.
- Keep history initialization resilient when optional tools are missing.
- If a dependency is optional, skip quietly unless explicitly enabled.

## Validation checklist
- zsh syntax remains valid.
- Startup smoke test stays quiet.
- Existing user-facing behavior is preserved unless explicitly requested.
