#!/usr/local/bin/fish

if type emacs > /dev/null 2>&1
  alias en 'emacsclient -nw -a ""'
  alias em 'emacsclient --create-frame -a ""'
  alias ekill='emacsclient -e "(kill-emacs)"'
end

if type nvim > /dev/null 2>&1
  alias vi='nvim'
  alias vim='nvim'
end


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

# Rust
if test -d $HOME/.cargo
  source $HOME/.cargo/env
  set PATH $HOME/.wasme/bin $PATH
  set -gx WASMTIME_HOME "$HOME/.wasmtime"
  string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH
end

if test -d /usr/local/share/git-core/contrib/diff-highlight/
  set -x PATH $PATH:/usr/local/share/git-core/contrib/diff-highlight
end

direnv hook fish | source
status --is-interactive; and source (pyenv init - | psub)
status --is-interactive; and source (rbenv init -|psub)
status --is-interactive; and source (nodenv init -|psub)


set -x PATH $HOME/Library/Python/3.7/bin $PATH

if type ghq > /dev/null 2>&1
    set -x GHQ_ROOT $HOME/workspace/repos

    function fd
      cd (ghq list --full-path | fzf --layout reverse)
    end
end

set -x LANG "ja_JP.UTF-8"
set -x LC_CTYPE ja_JP.UTF-8
set JAVA_HOME `/usr/libexec/java_home -v xx`

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/google-cloud-sdk/path.fish.inc' ]; . '/usr/local/google-cloud-sdk/path.fish.inc'; end

