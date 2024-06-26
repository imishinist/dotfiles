#!/bin/bash -e

bin/setup

echo "Checking submodule ..."
SUBMODULE_NEED_UPDATE=0
for submodule in $(git submodule | awk '{print $2}'); do
    if [ ! -d "$submodule" ] || [ -z "$(ls -A $submodule)" ]; then
        echo "Need to fetch submodule \"$submodule\""
        SUBMODULE_NEED_UPDATE=1
    fi
done

if [ $SUBMODULE_NEED_UPDATE -eq 1 ]; then
    git submodule init && git submodule update --depth 1
fi

bin/mitamae local $@ lib/recipe.rb
