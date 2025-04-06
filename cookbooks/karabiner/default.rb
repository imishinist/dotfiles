include_cookbook 'functions'

case node[:os]
when 'darwin'
  brew 'karabiner-elements' do
    cask true
  end
else
  raise NotImplementedError
end

directory "#{ENV['HOME']}/.config/karabiner"

dotfile '.config/karabiner/karabiner.json' do
  source '.config/karabiner/karabiner.json'
end

dotfile '.config/karabiner/assets' do
  source '.config/karabiner/assets'
end
