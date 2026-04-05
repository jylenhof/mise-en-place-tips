# Tips 001: Installing at least two tools from the same github repository, with tools not in the mise registry

[Tips_001](./Tips_001/)

If a tool is not found in the official mise registry, you can explicitly define how `mise` should find and install it within your `mise.toml` file using github backend. What is important here is that one tool_alias should always have something different from an another one.

> [Note]
> Don't succeed to handle the line length on line 4... If you had an idea that works, I'm interested.

## Case 1: One tool has the name of the repo

Use it as a github specified backend... (example here matchlock)
The other one has to be a tool_alias to be able to be installed
Both tools need to specify asset_pattern for platforms

## Case 2: None tool has the name of the repo

Create tool_alias for both, but you need to set asset_pattern for both to have something different between two backends.
Both tools need to specify asset_pattern for platforms
