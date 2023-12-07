VEGETA_VERSION = '12.11.1'.freeze

github_binary 'vegeta' do
  repository 'tsenart/vegeta'
  version "v#{VEGETA_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'darwin' : 'linux')
  archive "vegeta_#{VEGETA_VERSION}_#{platform}_amd64.tar.gz"
  binary_path "vegeta"
end