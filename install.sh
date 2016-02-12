#!/bin/bash

function install_prezto() {
    if [ ! -d "${ZDOTDIR:-$HOME}/.zprezto" ]; then
        invoke 'git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"'
    fi
    return;
}

install_prezto
