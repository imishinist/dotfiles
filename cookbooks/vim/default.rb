# NeoVim
directory "#{ENV['HOME']}/.config" do
  owner node[:user]
end

# TODO: ubuntu
package 'neovim'

dotfile '.config/nvim'

# Vim
dotfile '.vimrc'
dotfile '.config/vim'
