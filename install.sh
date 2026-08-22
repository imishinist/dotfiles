#!/bin/bash

set -euo pipefail

readonly root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$root_dir"

bin/setup
git submodule update --init --recursive --depth 1

bin/mitamae local "$@" lib/recipe.rb
