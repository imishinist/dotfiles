#!/usr/local/bin/fish

################################################################################
# Environment variables
################################################################################

set -x LANG ja_JP.UTF-8
set -x LC_CTYPE ja_JP.UTF-8

set -x LESSCHARSET utf-8
set -x EDITOR nvim
set -x VISUAL nvim

set -x GPG_TTY $(tty)

# Go
set -gx GOBIN $HOME/go/bin
set -gx CGO_ENABLED 0
set -gx GOENV_ROOT $HOME/.goenv

# Nodejs
set -gx VOLTA_HOME $HOME/.volta

################################################################################
# Binding
################################################################################

bind \cd delete-char

# alias
alias ls='eza'
alias en 'emacsclient -nw -a ""'
alias em 'emacsclient --create-frame -a ""'
alias ekill='emacsclient -e "(kill-emacs)"'
alias vi='nvim'
alias vim='nvim'


################################################################################
# Path 
################################################################################

# unset
set -e fish_user_paths

# Go
fish_add_path $GOBIN
fish_add_path $GOENV_ROOT/bin
fish_add_path $GOENV_ROOT/shims

# Rust
fish_add_path $HOME/.cargo/bin

# Nodejs
fish_add_path $VOLTA_HOME/bin

# Python
fish_add_path $HOME/.rye/shims

# Ruby
fish_add_path $HOME/.rbenv/bin

# Java
# NOTE: ruby is not installed with mitamae.
if type java >/dev/null 2>&1
  set JAVA_HOME `/usr/libexec/java_home -v xx`
  fish_add_path /opt/homebrew/opt/openjdk@11/bin
end

fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin

################################################################################
# load
################################################################################

. $HOME/.config/fish/functions/common.fish
. $HOME/.config/fish/functions/pet.fish
. $HOME/.config/fish/config.local.fish
. $HOME/.config/fish/config.custom.fish

set --local brew_path /opt/homebrew
set --local brew_cask_path {$brew_path}/Caskroom
set --local google_cloud_sdk_path {$brew_cask_path}/google-cloud-sdk/latest/google-cloud-sdk
if [ -f {$google_cloud_sdk_path}/path.fish.inc ]; . {$google_cloud_sdk_path}/path.fish.inc; end

################################################################################
# source
################################################################################

# Go
if test -d $GOENV_ROOT
  status --is-interactive; and source (goenv init - | psub)
end

# Ruby
# NOTE: ruby is not installed with mitamae.
if test -d $HOME/.rbenv
  status --is-interactive; and source (rbenv init - | psub)
end

# direnv
status --is-interactive; and source (direnv hook fish | psub)

# starship
status --is-interactive; and source (starship init fish | psub)
