# Auto update/install tools when entering project with a way to disable it by user addition in their .mise.local.toml

This tip demonstrates how to configure `mise` to automatically update or install tools defined in your `mise.toml` whenever you enter a project directory. It also provides a mechanism for users to disable this automatic update if they prefer.

## How it works

The `mise.toml` file includes a `hooks.enter` script. This script is executed every time you navigate into the project directory (or any subdirectory within it).

The script performs the following actions:

1. **Checks for `TOOLS_AUTO_UPDATE_DISABLE`**: If the environment variable `TOOLS_AUTO_UPDATE_DISABLE` is set, the update process is skipped entirely. This allows individual users to opt-out of the automatic updates.
2. **Checks for `TOOLS_AUTO_UPDATE_SILENT`**: If `TOOLS_AUTO_UPDATE_SILENT` is set, the `mise upgrade --local` command runs in quiet mode, suppressing output. Otherwise, it provides verbose output.
3. **Executes `mise upgrade --local`**: This command ensures that all tools specified in the local `mise.toml` are installed and updated to their latest compatible versions.

## Configuration

Add the following to your project's `mise.toml`:

```toml
[settings]
experimental = true # Required for hooks

[tools]
terraform = "latest"
tflint = "latest"
uv = "latest"

[[hooks.enter]]
script = '''
#!/usr/bin/env bash
if [ -z ${TOOLS_AUTO_UPDATE_DISABLE} ]; then
  if [ -z ${TOOLS_AUTO_UPDATE_SILENT} ]; then
    echo "Update local tools"
    mise upgrade --local
    echo "End of Update local tools"
  else
    mise upgrade --local --quiet
  fi
fi
'''
```

## Disabling Auto-Updates

If you, as a user, wish to disable this automatic update behavior for a specific project, you can set the `TOOLS_AUTO_UPDATE_DISABLE` environment variable in your personal `.mise.local.toml` file for that project.

Create or edit `~/.config/mise/config.toml` (or `.mise.local.toml` in the project root for project-specific settings) and add:

```toml
[env]
TOOLS_AUTO_UPDATE_DISABLE = "1"
```

This will prevent the `mise upgrade --local` command from running when you enter the project directory.

## Silent Auto-Updates

To run the auto-update silently without disabling it entirely, you can set `TOOLS_AUTO_UPDATE_SILENT` in your `.mise.local.toml` or as an environment variable:

```toml
[env]
TOOLS_AUTO_UPDATE_SILENT = "1"
```
