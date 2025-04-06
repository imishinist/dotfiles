
case node[:os]
when 'darwin'
  brew 'multipass' do
    cask true
  end
when 'linux'
  snap 'multipass' do
    classic true
  end
end
