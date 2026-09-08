# Nextcloud module

This document covers the Nextcloud helper in [modules/.zsh_nextcloud](../../modules/.zsh_nextcloud).

## Purpose

The Nextcloud module provides small helper commands for working with an `rclone` remote that points to a Nextcloud instance. It is designed to make sync and mount operations easier without embedding complicated shell logic into the main runtime.

## Main behavior

- defines default remote names and local storage locations
- validates that `rclone` is installed and that the remote is configured
- exposes `nextcloud_ls`, `nextcloud_sync`, `nextcloud_sync_up`, `nextcloud_sync_down`, and `nextcloud_mount`
- adds convenience aliases like `nextcloud-sync`, `nc-up`, and `nc-ls`

## Idea behind the module

It treats cloud storage like a project-level sync target: the shell offers a simple command set instead of forcing the developer to remember raw `rclone` commands for every task.

## Recommended workflow

```bash
rclone config
nextcloud_ls
nextcloud_sync_up --dry-run
nextcloud_sync_down --remote-path /Photos --local-dir ~/Nextcloud/photos
```

This is the most natural workflow for a user who keeps folder content synchronized to and from a cloud-backed remote.

## Setup

```bash
# configure an rclone remote first
rclone config

# then use the defaults or override them in the shell
export NEXTCLOUD_REMOTE_NAME=nextcloud
export NEXTCLOUD_REMOTE_PATH=/
export NEXTCLOUD_LOCAL_DIR="$HOME/Nextcloud"
source ~/.zshrc
```

Once the remote exists and the variables are set, the shell helpers make common Nextcloud sync and mount tasks much easier to execute.
