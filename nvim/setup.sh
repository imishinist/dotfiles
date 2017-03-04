#!/bin/bash

if [[ ! -e ~/.config/nvim ]]; then
    mkdir -p ~/.config/nvim
fi

ln -nsf $(cd $(dirname $0) && pwd)/** ~/.config/nvim
echo ln -nsf $(cd $(dirname $0) && pwd)/** ~/.config/nvim
