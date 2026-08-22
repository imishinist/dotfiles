#!/bin/bash

set -euo pipefail

readonly root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$root_dir"

while IFS=$'\t' read -r repository current_version; do
  release=$(curl -fsSL "https://api.github.com/repos/${repository}/releases/latest")
  latest_tag=$(jq -r '.tag_name' <<<"$release")
  latest_version=$(sed -E 's/^[^0-9]*//' <<<"$latest_tag")

  if [[ "$current_version" != "$latest_version" ]]; then
    release_url=$(jq -r '.html_url' <<<"$release")
    printf '%-40s %s -> %s\n  %s\n' "$repository" "$current_version" "$latest_version" "$release_url"
  fi
done < <(bin/extract-package-versions.sh)
