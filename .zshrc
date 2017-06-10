#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
export XDG_CONFIG_HOME=$HOME/.config

if [[ -e /usr/libexec/path_helper ]]; then
    eval $(/usr/libexec/path_helper -s)
fi
bindkey -e

# Go
export GOPATH=$HOME/workspace/golang
export GOROOT=$(go env GOROOT)
export PATH=$GOPATH/bin:$PATH

# Node.js
NVM_HOME=${HOME}/.nvm
if [ -e "${NVM_HOME}" ]; then
    source ${NVM_HOME}/nvm.sh
    nvm use stable
    NODE_PATH=${HOME}/.nvm/current/lib/node_modules
fi

# Ruby
if [ -d ${HOME}/.rbenv ] ; then
    export PATH=$HOME/.rbenv/bin:$PATH
    eval "$(rbenv init -)"
fi

# Rust
if [[ -d $HOME/.cargo ]]; then
    export PATH=$HOME/.cargo/bin:$PATH
fi

# PHP
if type brew >/dev/null 2>&1; then
    export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"
fi

# Java
if [[ -e /usr/libexec/java_home ]]; then
    export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
fi

# Git diff
if [[ -e /usr/local/share/git-core/contrib/diff-highlight ]]; then
    export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
fi

# source own profile
if [[ -e $HOME/.profile ]]; then
    source $HOME/.profile
fi
