# imishinist's dotfiles

Personal dotfiles for macOS, Ubuntu, and Arch Linux. Vim remains available for
Linux hosts where Neovim is impractical; Neovim uses the Lazy-based
configuration in `config/.config/nvim-lazynvim`.

## Install

The bootstrap requires Git, curl, and tar. On a new Linux host, install system
packages first, then apply the user configuration:

```bash
# Ubuntu
sudo -E bin/mitamae local roles/ubuntu/package.rb

# Arch Linux
sudo -E bin/mitamae local roles/arch/package.rb

./install.sh
```

On macOS, `./install.sh` also bootstraps Homebrew when necessary.

Use a [Nerd Font](https://www.nerdfonts.com/font-downloads) for icons in terminal
tools and Neovim.

## Neovim

Plugins are managed with Lazy:

```vim
:Lazy
```

Language servers and related tools are deliberately not installed system-wide.
Install only the configured tools when needed:

```vim
:MasonToolsInstall
```

## Maintenance

Run local syntax and consistency checks:

```bash
bin/check
```

List recipes whose pinned GitHub release is outdated:

```bash
./update-check.sh
```

Preview obsolete versioned directories under `~/bin` and remove them only after
reviewing the output:

```bash
bin/clean-bin.sh
bin/clean-bin.sh --delete
```
