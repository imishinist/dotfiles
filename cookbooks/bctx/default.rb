BCTX_VERSION = '0.4.3'.freeze

github_binary 'bctx' do
  repository 'orisano/bctx'
  version "v#{BCTX_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'Darwin' : 'Linux')
  archive "bctx_#{BCTX_VERSION}_#{platform}_x86_64.tar.gz"
  binary_path "bctx"
end
