return unless node[:platform] == 'darwin'

brew 'rectangle' do
  cask true
end
