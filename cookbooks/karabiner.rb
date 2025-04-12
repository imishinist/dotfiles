case node[:os]
when 'darwin'
  brew 'karabiner-elements' do
    cask true
  end
else
  raise NotImplementedError
end

directory "#{ENV['HOME']}/.config/karabiner"

dotfile '.config/karabiner/karabiner.json'
dotfile '.config/karabiner/assets'
