VEGETA_VERSION = '12.12.0'.freeze

cli_binary 'vegeta' do
  repository 'tsenart/vegeta'
  version "v#{VEGETA_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'darwin' : 'linux')
  arch = node[:arch] == 'x86_64' ? 'amd64' : 'arm64'
  release_name "vegeta_#{VEGETA_VERSION}_#{platform}_#{arch}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end
