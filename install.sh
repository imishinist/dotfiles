#!/bin/bash -e

bin/setup

echo "Checking submodule ..."
SUBMODULE_NEED_UPDAE=0
for submodule in $(git submodule | awk '{print $2}'); do
    if [ ! -d "$submodule" ] || [ -z "$(ls -A $submodule)" ]; then
        echo "Need to fetch submodule \"$submodule\""
        SUBMODULE_NEED_UPDAE=1
    fi
done

if [ $SUBMODULE_NEED_UPDAE -eq 1 ]; then
    git submodule init && git submodule update --depth 1
fi

case "$(uname)" in
  "Darwin")  bin/mitamae local $@ lib/recipe.rb ;;
  *) sudo -E bin/mitamae local $@ lib/recipe.rb ;;
esac
