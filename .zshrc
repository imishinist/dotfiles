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

export GOPATH=$HOME/.golang
export GOROOT=$(go env GOROOT)
export PATH="/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH:$GOPATH/bin"
export EDITOR='nvim'
export MANPAGER="col -b -x|vim -R -c 'set ft=man nolist nomod noma' -"

alias vi='nvim'
alias -g C=' | pbcopy'
bindkey -e

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

export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
# added by travis gem
[ -f /Users/taisuke/.travis/travis.sh ] && source /Users/taisuke/.travis/travis.sh
