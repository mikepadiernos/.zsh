# NVIDIA module

This document covers the NVIDIA compatibility alias in [modules/.zsh_nvidia](../../modules/.zsh_nvidia).

## Purpose

The NVIDIA module provides a small compatibility alias for launching Steam with the NVIDIA PRIME rendering configuration. It is a targeted fix for Linux systems that use hybrid graphics and benefit from the NVIDIA offload path.

## Main behavior

- defines a `steam` alias that sets the NVIDIA environment variables before launching the program
- keeps the environment change limited to the invocation itself

## Idea behind the module

This is a highly specific hardware workaround. It avoids a broad system change and instead ensures that the app runs in the correct graphics stack when the machine is configured for NVIDIA offload.

## Recommended workflow

```bash
source ~/.zshrc
steam
```

Use this when the system is running a hybrid graphics setup that requires offload variables to be set for the app launch.

## Setup

```bash
source ~/.zshrc
# no extra setup is required beyond having Steam installed
```

The module is effectively a convenience alias and does not require broader runtime changes.
