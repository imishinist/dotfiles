#!/bin/bash

source util.sh

for f in .??*;
do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    if [[ ! -e ~/$f ]]; then
        invoke 'ln -s $(cd $(dirname $0) && pwd)/$f ~/'
    fi
done

for filepath in $(cd $(dirname $0) && pwd)/*; do
    if [[ -d $filepath ]]; then
        if [[ -e $filepath/setup.sh ]]; then
            bash $filepath/setup.sh
        fi
    fi
done
