#!/usr/local/bin/fish

### common
set -x LANG "ja_JP.UTF-8"
set -x LC_CTYPE ja_JP.UTF-8

set -x LESSCHARSET utf-8
set -x EDITOR nvim
set -x VISUAL nvim
set -x GPG_TTY $(tty)

fish_add_path $HOME/.local/bin
fish_add_path $HOME/bin

bind \cd delete-char

### Alias
alias ls='eza'
alias en 'emacsclient -nw -a ""'
alias em 'emacsclient --create-frame -a ""'
alias ekill='emacsclient -e "(kill-emacs)"'
alias vi='nvim'
alias vim='nvim'

### Language

# Go
if test -d $HOME/.goenv
  set -gx GOENV_ROOT $HOME/.goenv
  fish_add_path $GOENV_ROOT/bin
  eval (goenv init - | source)
  fish_add_path $GOENV_ROOT/shims
else
  if type go > /dev/null 2>&1
    set -gx GOPATH $HOME/workspace/golang
    set -gx GOROOT (go env GOROOT)
    fish_add_path $GOPATH/bin

    fish_add_path $HOME/go/bin
  end
end
set -gx CGO_ENABLED 0


# Rust
fish_add_path $HOME/.cargo/bin

# Nodejs
set -gx VOLTA_HOME "$HOME/.volta"
fish_add_path $VOLTA_HOME/bin

# Python
fish_add_path $HOME/.rye/shims

# Ruby
# NOTE: ruby is not installed with mitamae.
if test -d $HOME/.rbenv
  fish_add_path $HOME/.rbenv/bin
  status --is-interactive; and source (rbenv init -|psub)
end

if type java >/dev/null 2>&1
  set JAVA_HOME `/usr/libexec/java_home -v xx`
  fish_add_path /opt/homebrew/opt/openjdk@11/bin
end

# direnv tool
direnv hook fish | source


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/google-cloud-sdk/path.fish.inc'; end
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc' ]; . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'; end

. $HOME/.config/fish/functions/common.fish
. $HOME/.config/fish/functions/pet.fish
. $HOME/.config/fish/config.local.fish
if [ -f $HOME/.config/fish/config.custom.fish ]; . $HOME/.config/fish/config.custom.fish; end

starship init fish | source
