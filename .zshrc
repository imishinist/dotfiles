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

export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH:$GOPATH/bin"
export EDITOR='vim'
export MANPAGER="col -b -x|vim -R -c 'set ft=man nolist nomod noma' -"

alias vi='vim'
alias -g C=' | pbcopy'

if [ -d ${HOME}/.rbenv ] ; then
    PATH=${HOME}/.rbenv/bin:${PATH}
    export PATH
    eval "$(rbenv init -)"
fi

NVM_HOME=${HOME}/.nvm
if [ -e "${NVM_HOME}" ]; then
    source ${NVM_HOME}/nvm.sh
    nvm use stable
    NODE_PATH=${HOME}/.nvm/current/lib/node_modules
fi
