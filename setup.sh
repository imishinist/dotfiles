#!/bin/bash

for f in .??* do
    [[ "$f" == ".git" ]] && continue
    [[ "$f" == ".DS_Store" ]] && continue
    if [[ ! -e ~/$f ]]; then
        ln -s $(cd $(dirname $0) && pwd)/$f ~/
        echo ln -s $(cd $(dirname $0) && pwd)/$f ~/
    fi
done

for filepath in $(cd $(dirname $0) && pwd)/*; do
    if [[ -d $filepath ]]; then
        if [[ -e $filepath/setup.sh ]]; then
            bash $filepath/setup.sh
        fi
    fi
done
