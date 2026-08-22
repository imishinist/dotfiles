BCTX_VERSION = '0.4.3'.freeze

cli_binary 'bctx' do
  repository 'orisano/bctx'
  version "v#{BCTX_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'Darwin' : 'Linux')
  arch = (node[:arch] == 'x86_64' ? 'x86_64' : 'arm64')
  release_name "bctx_#{BCTX_VERSION}_#{platform}_#{arch}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end
