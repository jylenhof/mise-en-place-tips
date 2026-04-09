# Using docker with mise with at least one known plugin in this list: buildx, compose, scout

When you manage Docker plugins like `buildx`, `compose`, or `scout` via `mise`, they are installed into specific versioned directories that the system-wide `docker` CLI doesn't know about by default.

This tip provides a way to bridge that gap by using a wrapper script that automatically registers the `mise`-managed plugin paths within Docker's configuration.

## How it works

The script `mise-tasks/docker.sh` performs the following steps:

1. **Locates the plugins**: It uses `which` to find the active paths for `docker-buildx`, `docker-compose`, and `docker-scout` as managed by `mise`.
2. **Updates Docker Config**: It modifies `~/.docker/config.json` to add these paths to the `cliPluginsExtraDirs` array.
3. **Executes Docker**: Finally, it passes all arguments to the real `docker` binary, ensuring a seamless experience.

## Usage

To use this, you can define a task or an alias in your `mise.toml`:

```toml
[tasks.docker]
run = "./mise-tasks/docker.sh"
description = "Run docker with mise-managed plugins"

[alias]
d = "docker"
```

Alternatively, you can set an alias in your shell to point to the script so that every `docker` command automatically ensures the plugins are correctly mapped.

> [!TIP]
> This approach is particularly useful in CI environments or shared development setups where plugin versions might change frequently.
