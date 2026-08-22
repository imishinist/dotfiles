#!/bin/bash

set -euo pipefail

if [[ $# -gt 1 || (${1:-} != "" && ${1:-} != "--delete") ]]; then
  echo "usage: $0 [--delete]" >&2
  exit 1
fi

readonly bin_dir="${HOME}/bin"
readonly delete=${1:-}

if [[ ! -d "$bin_dir" ]]; then
  exit 0
fi

for candidate in "$bin_dir"/*/; do
  [[ -d "$candidate" ]] || continue

  name=$(basename "$candidate")
  [[ "$name" =~ ^.+-(v|jq-)?[0-9] ]] || continue

  referenced=false
  for link in "$bin_dir"/*; do
    [[ -L "$link" ]] || continue
    target=$(readlink "$link")
    [[ "$target" = /* ]] || target="$bin_dir/$target"
    if [[ "${target%/*}/" == "$candidate" || "$target" == "$candidate"* ]]; then
      referenced=true
      break
    fi
  done

  $referenced && continue

  if [[ "$delete" == "--delete" ]]; then
    echo "remove: $candidate"
    rm -rf -- "$candidate"
  else
    echo "would remove: $candidate"
  fi
done
