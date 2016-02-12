#!/bin/bash

source util.sh

if [[ ! -e ~/.bundle ]]; then
    mkdir -p ~/.bundle
fi

if [[ ! -e ~/.bundle/config ]]; then
    invoke 'ln -s $(cd $(dirname $0) && pwd)/config ~/.bundle/'
fi
