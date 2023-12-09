#!/bin/bash -ex

bin/setup

if [ ! -d config/.config/nvim/dein/repos/github.com/Shougo/dein.vim ] || \
   [ ! -d config/.config/vim/dein/repos/github.com/Shougo/dein.vim ] || \
   [ ! -d plugins/itamae-plugin-resource-cask ]; then
    git submodule init && git submodule update --depth 1
fi

case "$(uname)" in
  "Darwin")  bin/mitamae local $@ lib/recipe.rb ;;
  *) sudo -E bin/mitamae local $@ lib/recipe.rb ;;
esac
