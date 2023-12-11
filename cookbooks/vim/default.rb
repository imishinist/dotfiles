# NeoVim
directory "#{ENV['HOME']}/.config" do
  owner node[:user]
end
include_cookbook 'functions'

git "#{ENV['HOME']}/.local/share/nvim/site/pack/packer/start/packer.nvim" do
  action :sync
  repository 'https://github.com/wbthomason/packer.nvim'
  user node[:user]
  depth 1
end

directory "#{ENV['HOME']}/.cache/nvim/undo" do
  owner node[:user]
end

brew 'lua-language-server'
brew 'tree-sitter'

# TODO: ubuntu

case node[:os]
when 'darwin'
  package 'neovim'
when 'linux'
  snap 'nvim' do
    classic true
  end
end


dotfile '.config/nvim'

# Vim
dotfile '.vimrc'
dotfile '.config/vim'
