package 'tmux'

dotfile '.tmux.conf'
dotfile '.tmux.conf.local' do
  case node[:os]
  when "darwin"
    source ".tmux.conf.darwin"
  when "linux"
    source ".tmux.conf.linux"
  else
    raise NotImplmentedError
  end
end
