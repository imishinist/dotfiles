#!/bin/bash

if [[ ! -e ~/.config/fish ]]; then
    mkdir -p ~/.config/fish
fi

# curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fish -c fisher > /dev/null 2>&1

ln -nsf $(cd $(dirname $0) && pwd) ~/.config/
echo  ln -nsf $(cd $(dirname $0) && pwd) ~/.config/
