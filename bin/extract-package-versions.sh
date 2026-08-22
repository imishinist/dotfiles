#!/bin/bash

set -euo pipefail

readonly root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root_dir"

while IFS=: read -r file _ definition; do
  constant=${definition%% *}
  version=$(printf '%s\n' "$definition" | cut -d"'" -f2)
  repository=$(rg -A 6 -m 1 "${constant}" "$file" | awk '/repository/ { gsub(/['"'"']/, "", $2); print $2; exit }')
  [[ -n "$repository" ]] && printf '%s\t%s\n' "$repository" "$version"
done < <(rg -n "^[A-Z0-9_]+_VERSION = '[^']+'" cookbooks)
