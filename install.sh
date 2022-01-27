#!/bin/bash -ex

bin/setup

if [ ! -f config/.config/nvim/dein/repos/github.com/Shougo/dein.vim ]; then
    git submodule init && git submodule update --depth 1
fi

case "$(uname)" in
  "Darwin")  bin/mitamae local $@ lib/recipe.rb ;;
  *) sudo -E bin/mitamae local $@ lib/recipe.rb ;;
esac
