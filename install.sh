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

function install_rbenv() {
    if [ ! -d "$HOME/.rbenv" ]; then
        git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
        git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    fi
}

install_prezto
install_neobundle
install_rbenv
