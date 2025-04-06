include_cookbook 'functions'

case node[:os]
when 'darwin'
  brew 'alacritty' do
    cask true
  end
else
  raise NotImplementedError
end


dotfile '.config/alacritty' do
  source '.config/alacritty'
end
