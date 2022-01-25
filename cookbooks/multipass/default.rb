
case node[:os]
when 'darwin'
  include_cookbook 'brew'
  brew 'multipass' do
    opt '--cask'
  end
when 'linux'
  snap 'multipass' do
    classic true
  end
end
