
case node[:os]
when 'darwin'
  cask 'multipass'
when 'linux'
  snap 'multipass' do
    classic true
  end
end
