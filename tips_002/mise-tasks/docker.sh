#!/usr/bin/env bash

# 1. Get the current active directories for the plugins
PLUGINS=("buildx" "compose" "scout")
NEW_DIRS=()
for p in "${PLUGINS[@]}"; do
  BIN=$(which "docker-$p" 2>/dev/null)
  if [ -n "$BIN" ]; then
    NEW_DIRS+=("$(dirname "$BIN")")
  fi
done

if [ ${#NEW_DIRS[@]} -eq 0 ]; then
  echo "Error: No docker plugins (buildx, compose, scout) found." >&2
  exit 1
fi
CONFIG_FILE="${HOME}/.docker/config.json"

echo "Current active plugin directories: ${NEW_DIRS[*]}"

# 2. Ensure config exists
mkdir -p "$(dirname "${CONFIG_FILE}")"
[ ! -s "${CONFIG_FILE}" ] && echo "{}" >"${CONFIG_FILE}"

# 3. Logic:
# - Filter out any old paths that contain the plugin names
# - Add the current one
# - Keep everything else unique
tmp=$(mktemp)
DIRS_JSON=$(printf '%s\n' "${NEW_DIRS[@]}" | jq -R . | jq -cs .)
jq --argjson new_dirs "$DIRS_JSON" '
  .cliPluginsExtraDirs = (
    # Take the existing list (or empty)
    (.cliPluginsExtraDirs // []) |
    # Remove any entry that looks like an old plugin path
    map(select(test("docker-(buildx|compose|scout)") | not)) |
    # Add the new path and ensure the list is unique
    (. + $new_dirs) | unique
  )
' "${CONFIG_FILE}" >"$tmp" && mv "$tmp" "${CONFIG_FILE}"

echo "Config updated successfully."
docker "$@"
