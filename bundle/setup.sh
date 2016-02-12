#!/bin/bash

if [[ ! -e ~/.bundle ]]; then
    mkdir -p ~/.bundle
fi

if [[ ! -e ~/.bundle/config ]]; then
    ln -s $(cd $(dirname $0) && pwd)/config ~/.bundle/
    echo ln -s $(cd $(dirname $0) && pwd)/config ~/.bundle/
fi
