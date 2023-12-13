# NeoVim
directory "#{ENV['HOME']}/.config"
include_cookbook 'functions'

git "#{ENV['HOME']}/.local/share/nvim/site/pack/packer/start/packer.nvim" do
  action :sync
  repository 'https://github.com/wbthomason/packer.nvim'
  depth 1
end

directory "#{ENV['HOME']}/.cache/nvim/undo"


# TODO: ubuntu

case node[:os]
when 'darwin'
  package 'neovim'
  brew 'lua-language-server'
  brew 'tree-sitter'
when 'linux'
  snap 'nvim' do
    classic true
  end
end


dotfile '.config/nvim'

# Vim
dotfile '.vimrc'
dotfile '.config/vim'
