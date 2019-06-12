#!/bin/bash

if [[ ! -e ~/.emacs.d ]]; then
    mkdir -p ~/.emacs.d
fi

ln -nsf $(cd $(dirname $0) && pwd)/** ~/.emacs.d
echo ln -nsf $(cd $(dirname $0) && pwd)/** ~/.emacs.d
