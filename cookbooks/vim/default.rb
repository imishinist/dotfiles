# NeoVim
include_cookbook 'functions'

NEOVIM_VERSION = '0.9.4'.freeze

cli_binary 'nvim' do
  repository 'neovim/neovim'
  version "v#{NEOVIM_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'macos' : 'linux64')
  release_name "nvim-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
  bin_path "bin/nvim"
  tar_options '--strip-components 1'
end

directory "#{ENV['HOME']}/.config"
directory "#{ENV['HOME']}/.cache/nvim/undo"

git "#{ENV['HOME']}/.local/share/nvim/site/pack/packer/start/packer.nvim" do
  action :sync
  repository 'https://github.com/wbthomason/packer.nvim'
  depth 1
end

# TODO: ubuntu

case node[:os]
when 'darwin'
  brew 'lua-language-server'
  brew 'tree-sitter'
end


dotfile '.config/nvim'

# Vim
dotfile '.vimrc'
dotfile '.config/vim'
