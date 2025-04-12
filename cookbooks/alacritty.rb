case node[:os]
when 'darwin'
  brew 'alacritty' do
    cask true
  end
else
  raise NotImplementedError
end


dotfile '.config/alacritty'
