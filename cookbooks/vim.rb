# NeoVim

NEOVIM_VERSION = '0.11.1'.freeze
cli_binary 'nvim' do
  repository 'neovim/neovim'
  version "v#{NEOVIM_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'macos' : 'linux')
  arch = node[:arch] == 'x86_64' ? 'x86_64' : 'arm64'
  release_name "nvim-#{platform}-#{arch}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
  bin_path "bin/nvim"
  tar_options '--strip-components 1'
end

directory "#{ENV['HOME']}/.config"

## tree-sitter
TREE_SITTER_VERSION = '0.25.3'.freeze
cli_binary 'tree-sitter' do
  repository 'tree-sitter/tree-sitter'
  version "v#{TREE_SITTER_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'macos' : 'linux')
  release_name "tree-sitter-#{platform}-x64.gz"
  target_dir "#{ENV['HOME']}/bin"
  is_tarball false
end

dotfile '.config/nvim' do
  source '.config/nvim-lazynvim'
  # source '.config/nvim'
end

# Vim
dotfile '.vimrc'
dotfile '.config/vim'
