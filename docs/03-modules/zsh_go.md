# Go module

This document covers the Go toolchain setup in [modules/.zsh_go](../../modules/.zsh_go).

## Purpose

The Go module ensures the shell is prepared for Go development when the toolchain is installed. It configures the standard Go environment variables and adds the Go bin directory to `PATH`.

## Main behavior

- checks whether `go` is installed
- sets `GOPATH` to `~/.go` unless it is already defined
- sets `GOBIN` to `$GOPATH/bin` unless it is already defined
- prepends the Go binary directory to `PATH` so `go` and installed tools are available immediately

## Idea behind the module

This is a basic runtime helper for Go workflows. It keeps the developer environment aligned with standard Go conventions without adding a custom tool abstraction.

## Recommended workflow

```bash
source ~/.zshrc
go version
mkdir -p ~/src && cd ~/src
 go mod init example.com/project
```

When Go is installed, the shell exposes the standard toolchain with no extra manual PATH changes.

## Setup

```bash
# install Go with your preferred package manager, then reload the shell
source ~/.zshrc

go version
```

The module expects a valid Go installation to exist already. Once it does, it sets the environment in the standard, predictable way.
