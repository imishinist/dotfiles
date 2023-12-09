BCTX_VERSION = '0.4.3'.freeze

cli_binary 'bctx' do
  repository 'orisano/bctx'
  version "v#{BCTX_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'Darwin' : 'Linux')
  release_name "bctx_#{BCTX_VERSION}_#{platform}_x86_64.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end