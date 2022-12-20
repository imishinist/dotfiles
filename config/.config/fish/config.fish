#!/usr/local/bin/fish

set fish_greeting

### common
set -x LANG "ja_JP.UTF-8"
set -x LC_CTYPE ja_JP.UTF-8

### PATH
if test (uname -s) = "Darwin"
  fish_add_path /opt/homebrew/bin
  fish_add_path /opt/homebrew/sbin

  fish_add_path /opt/homebrew/opt/llvm/bin
end

fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin

### Editor

## emacs
if type emacs > /dev/null 2>&1
  alias en 'emacsclient -nw -a ""'
  alias em 'emacsclient --create-frame -a ""'
  alias ekill='emacsclient -e "(kill-emacs)"'
end

## Vim
if type nvim > /dev/null 2>&1
  alias vi='nvim'
  alias vim='nvim'
end


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
  end
end


# Rust
if test -d $HOME/.cargo
  fish_add_path $HOME/.cargo/bin
  fish_add_path $HOME/.wasme/bin
  set -gx WASMTIME_HOME "$HOME/.wasmtime"
  string match -r ".wasmtime" "$PATH" > /dev/null; or fish_add_path $WASMTIME_HOME/bin
end

## Volta
if test -d $HOME/.volta
  set -gx VOLTA_HOME "$HOME/.volta"
  fish_add_path $VOLTA_HOME/bin
end

# Python
if test -d $HOME/.pyenv
   set -gx PYENV_ROOT $HOME/.pyenv
   fish_add_path $PYENV_ROOT/bin
   status --is-interactive; and source (pyenv init - | psub)
   fish_add_path (pyenv root)/shims
end

# Ruby
if type rbenv > /dev/null 2>&1
  status --is-interactive; and source (rbenv init -|psub)
end

if type java >/dev/null 2>&1
  set JAVA_HOME `/usr/libexec/java_home -v xx`
  fish_add_path /opt/homebrew/opt/openjdk@11/bin
end

# direnv tool
if type direnv > /dev/null 2>&1
   direnv hook fish | source
end


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/google-cloud-sdk/path.fish.inc'; end
if [ -f '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc' ]; . '/opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc'; end

. $HOME/.config/fish/functions/common.fish
if test -f $HOME/.config/fish/config.local.fish
  . $HOME/.config/fish/config.local.fish
end
