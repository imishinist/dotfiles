#!/bin/bash

if [[ ! -e ~/.vim ]]; then
    mkdir -p ~/.vim
fi

if [[ ! -e ~/.vim/userautoload ]]; then
    ln -s $(cd $(dirname $0) && pwd)/userautoload ~/.vim/
    echo ln -s $(cd $(dirname $0) && pwd)/userautoload ~/.vim/
fi
