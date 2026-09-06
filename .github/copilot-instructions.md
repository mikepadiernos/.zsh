# Workspace Copilot Policy

This repository manages a zsh runtime. Prefer stable, quiet shell startup behavior over aggressive automation.

## Always apply
- Keep startup non-interactive for VPS and non-root environments.
- Avoid startup noise: no command-not-found output, no failed install chatter, no security prompts.
- Keep dependency auto-install opt-in.
- For auto-install flow: use mise first, then use brew only when mise has no matching package and only for non-root users.
- Keep runtime rooted at ~/.zsh and app configs in ~/.files.
- Do not reintroduce runtime dependency on ~/.files/.zsh/.zshrc.
- Keep zsh-job-queue available before zsh-abbr.
