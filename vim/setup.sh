#!/bin/bash

source util.sh

if [[ ! -e ~/.vim ]]; then
    mkdir -p ~/.vim
fi

if [[ ! -e ~/.vim/userautoload ]]; then
    invoke 'ln -s $(cd $(dirname $0) && pwd)/userautoload ~/.vim/'
fi
