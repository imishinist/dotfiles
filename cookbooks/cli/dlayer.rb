DLAYER_VERSION = '0.3.1'.freeze

cli_binary 'dlayer' do
  repository 'orisano/dlayer'
  version "v#{DLAYER_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'Darwin' : 'Linux')
  release_name "dlayer_#{DLAYER_VERSION}_#{platform}_x86_64.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end