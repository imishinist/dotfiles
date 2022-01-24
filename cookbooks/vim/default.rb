# NeoVim
directory "#{ENV['HOME']}/.config" do
  owner node[:user]
end
include_cookbook 'functions'

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
