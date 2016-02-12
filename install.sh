#!/bin/bash

function install_prezto() {
    if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
        git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    fi
    return;
}

function install_neobundle() {
    if [ ! -d "$HOME/.vim/bundle/neobundle.vim" ]; then
        curl -s https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
    fi
}

install_prezto
install_neobundle
