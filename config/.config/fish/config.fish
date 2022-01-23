#!/usr/local/bin/fish

### common
set -x LANG "ja_JP.UTF-8"
set -x LC_CTYPE ja_JP.UTF-8

### PATH
set -x PATH $HOME/bin $PATH
set -x PATH $HOME/.local/bin $PATH

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
if type go > /dev/null 2>&1
  set -x GOPATH $HOME/workspace/golang
  set -x GOROOT (go env GOROOT)
  set -x PATH $GOPATH/bin/ $PATH
end

# Node.js
if test -d $HOME/.nodebrew
  set -x PATH $HOME/.nodebrew/current/bin $PATH
end
if type nodenv > /dev/null 2>&1
   status --is-interactive; and source (nodenv init -|psub)
end


# Rust
if test -d $HOME/.cargo
  set -x PATH $HOME/.cargo/bin $PATH
  set PATH $HOME/.wasme/bin $PATH
  set -gx WASMTIME_HOME "$HOME/.wasmtime"
  string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH
end

# Python
if test -d $HOME/.pyenv
  set PYENV_ROOT $HOME/.pyenv
  set PATH $PYENV_ROOT/bin $PATH
  status --is-interactive; and source (pyenv init - | psub)
  set PATH (pyenv root)/shims $PATH
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