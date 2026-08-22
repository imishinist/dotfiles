DLAYER_VERSION = '0.3.1'.freeze

cli_binary 'dlayer' do
  repository 'orisano/dlayer'
  version "v#{DLAYER_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'Darwin' : 'Linux')
  arch = (node[:arch] == 'x86_64' ? 'x86_64' : 'arm64')
  release_name "dlayer_#{DLAYER_VERSION}_#{platform}_#{arch}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end
