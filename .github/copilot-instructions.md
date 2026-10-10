# Agent instructions

All tools are managed by [mise](https://mise.jdx.dev). Run them through mise so
the pinned versions from `.mise.toml` are used:

- Run checks: `mise x -- prek run --all-files`
- Commit (pre-commit hooks need the mise tools): `mise x -- git commit ...`
- GitHub CLI: `mise x gh@latest -- gh ...`
