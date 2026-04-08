# Installing at least two tools from the same GitHub repository when tools are not in the mise registry

If a tool is not found in the official mise registry, you can explicitly define how `mise` should find and install it within your `mise.toml` file using a GitHub backend. It is important that each `tool_alias` has a distinct value.

> [!NOTE]
> I haven't succeeded in handling the line length for line 4... If you have an idea that works, I'm interested.

## Case 1: One tool has the name of the repository

Use it as a GitHub-specified backend (e.g., matchlock).
The other tool must be defined as a `tool_alias` to be installable.
Both tools need to specify an `asset_pattern` for their respective platforms.

## Case 2: No tool has the name of the repository

Create `tool_alias` entries for both, and you need to set a unique `asset_pattern` for each to differentiate the two backends.
Both tools need to specify an `asset_pattern` for their respective platforms.
