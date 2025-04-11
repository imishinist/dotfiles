#!/usr/local/bin/fish

################################################################################
# Environment variables
################################################################################

set -q XDG_CONFIG_HOME || set -gx XDG_CONFIG_HOME $HOME/.config
set -q XDG_DATA_HOME || set -gx XDG_DATA_HOME $HOME/.local/share

set -g FISH_CONFIG_DIR $XDG_CONFIG_HOME/fish
set -g FISH_CONFIG $FISH_CONFIG_DIR/config.fish
set -g FISH_CACHE_DIR $HOME/.cache/fish

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
# source with cache
################################################################################

set -l CONFIG_CACHE $FISH_CACHE_DIR/config.fish
if test "$FISH_CONFIG" -nt "$CONFIG_CACHE"
  mkdir -p $FISH_CACHE_DIR
  echo '' >$CONFIG_CACHE

  # Go
  test -d $GOENV_ROOT && goenv init - >>$CONFIG_CACHE

  # Ruby
  # NOTE: ruby is not installed with mitamae.
  test -d $HOME/.rbenv && rbenv init - >> $CONFIG_CACHE

  # direnv
  type -q direnv && direnv hook fish >> $CONFIG_CACHE

  # starship
  type -q starship && starship init fish --print-full-init >> $CONFIG_CACHE

  set_color brmagenta --bold --underline
  echo "config cache updated"
  set_color normal
end
source $CONFIG_CACHE
