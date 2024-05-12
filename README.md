# imishinist's dotfiles

```bash
./install.sh
```

use [nerd-font](https://www.nerdfonts.com/font-downloads)

## get github binary for test

```bash:example
curl -sL --output-dir /tmp -O (bin/github-assets.sh neovim/neovim | fzf | awk '{print $2}')
```

## ubuntu-only

```bash
sudo -E bin/mitamae local roles/ubuntu/package.rb
```

## neovim

```
:PackerInstall
```

## TODO

- [ ] directory owner and groups for ubuntu
- [ ] install aws cli
- [ ] install gcloud cli
- [ ] install pyenv and python and other python tools
