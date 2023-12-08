DLAYER_VERSION = '0.3.1'.freeze

github_binary 'dlayer' do
  repository 'orisano/dlayer'
  version "v#{DLAYER_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'Darwin' : 'Linux')
  archive "dlayer_#{DLAYER_VERSION}_#{platform}_x86_64.tar.gz"
  binary_path "dlayer"
end