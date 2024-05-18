# NeoVim
include_cookbook 'functions'

NEOVIM_VERSION = '0.9.5'.freeze
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


# directory "#{ENV['HOME']}/.cache/nvim/undo"
# git "#{ENV['HOME']}/.local/share/nvim/site/pack/packer/start/packer.nvim" do
#   action :sync
#   repository 'https://github.com/wbthomason/packer.nvim'
#   depth 1
# end

# case node[:os]
# when 'darwin'
#   brew 'lua-language-server'
# end

TREE_SITTER_VERSION = '0.22.6'.freeze
cli_binary 'tree-sitter' do
  repository 'tree-sitter/tree-sitter'
  version "v#{TREE_SITTER_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'macos' : 'linux')
  release_name "tree-sitter-#{platform}-x64.gz"
  target_dir "#{ENV['HOME']}/bin"
  is_tarball false
end

# LUA_LANGUAGE_SERVER_VERSION = '3.7.3'.freeze
# cli_binary 'lua-language-server' do
#   repository 'LuaLS/lua-language-server'
#   version LUA_LANGUAGE_SERVER_VERSION
#   platform = (node[:platform] == 'darwin' ? 'darwin-x64' : 'linux-x64-musl')
#   release_name "lua-language-server-#{LUA_LANGUAGE_SERVER_VERSION}-#{platform}.tar.gz"
#   target_dir "#{ENV['HOME']}/bin"
#   bin_path "bin/lua-language-server"
# end

dotfile '.config/nvim' do
  source '.config/nvim-lazynvim'
end

# dotfile '.config/nvim'

# Vim
dotfile '.vimrc'
dotfile '.config/vim'
