
case node[:os]
when 'darwin'
  include_cookbook 'brew'
  brew 'multipass' do
    cask true
  end
when 'linux'
  snap 'multipass' do
    classic true
  end
end
