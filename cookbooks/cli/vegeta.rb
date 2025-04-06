VEGETA_VERSION = '12.12.0'.freeze

cli_binary 'vegeta' do
  repository 'tsenart/vegeta'
  version "v#{VEGETA_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'darwin' : 'linux')
  release_name "vegeta_#{VEGETA_VERSION}_#{platform}_amd64.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end
