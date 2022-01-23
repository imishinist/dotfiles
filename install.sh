#!/bin/bash

function install_brew() {
  if [[ $(uname) =~ "Darwin" ]]; then
    if ! type brew >/dev/null 2>&1; then
      read -rp "Install brew?[y/N]" IN
      if [[ ${IN} = [yY] ]]; then
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew tap Homebrew/bundle
      fi
    fi
  fi
}

function install_cask_app() {
  if [[ $(uname) =~ "Darwin" ]]; then
    echo "install cask application list:"
    echo "- alacritty"
    echo "- spectacle"
    echo ""
    read -rp "Install cask app?[y/N]" IN
    if [[ ${IN} = [yY] ]]; then
      brew cask install \
        alacritty \
        spectacle
    fi
  fi
}

function install_brew_app() {
  if [[ $(uname) =~ "Darwin" ]]; then
    echo "install brew application list:"
    read -rp "Install brew app?[y/N]" IN
    if [[ ${IN} = [yY] ]]; then
      brew install \
        pkg-config \
        fzf \
        direnv \
        fish \
        gnu-sed \
        moreutils \
        jq \
        neovim \
        protobuf \
        ripgrep \
        tig \
        tmux \
        hub \
        git
    fi
  fi
}

function install_golang() {
  if type go >/dev/null 2>&1; then
    echo -n ""
  else
    read -rp "Install golang?[y/N]" IN
    if [[ ${IN} = [yY] ]]; then
      if [[ $(uname) =~ "Darwin" ]]; then
        brew install go
      else
        echo "[Error]: install script doesn't exist"
      fi
    fi

    go get -u github.com/go-delve/delve/cmd/dlv
    go get -u github.com/motemen/ghq
    go get -u github.com/golang/mock/mockgen
    go get -u github.com/golang/protobuf/protoc-gen-go
    go get -u github.com/tsenart/vegeta
  fi
}

function install_nodebrew() {
  if [[ ! -d $HOME/.nodebrew ]]; then
    read -rp "Install nodebrew?[y/N]" IN
    if [[ ${IN} = [yY] ]]; then
      curl -L https://git.io/nodebrew | perl - setup
    fi
  fi
}

function install_gcloud_cli() {
  if type gcloud >/dev/null 2>&1; then
    echo -n ""
  else
    read -rp "Install gcloud cli?[y/N]" IN
    if [[ ${IN} = [yY] ]]; then
      curl https://sdk.cloud.google.com | bash
    fi
  fi
}

function install_aws_cli() {
  if type aws >/dev/null 2>&1; then
    echo -n ""
  else
    read -rp "Install aws cli?[y/N]" IN
    if [[ ${IN} = [yY] ]]; then
      pip3 install awscli --upgrade --user
    fi
  fi
}

# TODO
# install_brew
# install_rbenv
# install_cask_app
# install_brew_app
# install_golang
# install_nodebrew
# install_gcloud_cli
# install_aws_cli

set -ex

bin/setup

case "$(uname)" in
  "Darwin")  bin/mitamae local $@ lib/recipe.rb ;;
  *) sudo -E bin/mitamae local $@ lib/recipe.rb ;;
esac


