package 'zsh'

dotfile '.zshrc'
dotfile '.zshrc.local' do
  source ".zshrc.#{node[:platform]}"
end

dotfile '.zpreztorc'
dotfile '.zprofile'
dotfile '.zshenv'
dotfile '.zlogin'
dotfile '.zlogout'
