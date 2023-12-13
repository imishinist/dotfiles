#!/bin/bash

set -eu

if [ $# -gt 2 ] || [ $# -eq 0 ]; then
  echo "usage: $0 <owner>/<repo> [tag]" >&2
  exit 1
fi

readonly repo=$1
readonly tag=${2:-latest}

if [ "$tag" = "latest" ]; then
  url="https://api.github.com/repos/${repo}/releases/$tag"
else
  url="https://api.github.com/repos/${repo}/releases/tags/${tag}"
fi

curl -sL $url | jq -r '.assets[] | [.name, .browser_download_url] | @tsv'
