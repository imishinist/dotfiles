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

export GOPATH=$HOME/workspace/golang
export GOROOT=$(go env GOROOT)
export PATH="$GOPATH/bin:/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH"
export EDITOR='nvim'
export MANPAGER="col -b -x|nvim -R -c 'set ft=man nolist nomod noma' -"

alias vi='nvim'
alias -g C=' | pbcopy'
alias hi='highlight -u utf-8 -s edit-xcode'
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

export XDG_CONFIG_HOME=$HOME/.config
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

alias ch='cheat list | peco | xargs cheat show'

pomodoro() {
    echo Pomodoro ${1:-25} minutes \(break ${2:-5} minutes\) ... $3
    echo Pomodoro ${1:-25} minutes \(break ${2:-5} minutes\) ... $3 >> ~/pomodoro.log

    echo 'Start ...' `date`
    echo 'Start ...' `date` >> ~/pomodoro.log
    afplay /System/Library/Sounds/Glass.aiff
    sleep `expr 60 \* ${1:-25}`
    echo 'Break ...' `date`
    echo 'Break ...' `date` >> ~/pomodoro.log
    afplay /System/Library/Sounds/Glass.aiff
    pmset displaysleepnow
    sleep `expr 60 \* ${2:-5}`
    echo 'End ...' `date`
    echo 'End ...' `date` >> ~/pomodoro.log
    afplay /System/Library/Sounds/Glass.aiff
}
eval $(/usr/libexec/path_helper -s)
