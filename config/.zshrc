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
if type go >/dev/null 2>&1; then
    export GOPATH=$HOME/workspace/golang
    export GOROOT=$(go env GOROOT)
    export PATH=$GOPATH/bin:$PATH
fi


# Node.js
if [[ -e $HOME/.nodebrew/current/bin ]]; then
    export PATH=$HOME/.nodebrew/current/bin:$PATH
    nodebrew use stable
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

# Git diff
if [[ -e /usr/local/share/git-core/contrib/diff-highlight ]]; then
    export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
fi

[ -f ~/.zshrc.local ] && source ~/.zshrc.local
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
