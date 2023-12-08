# NOTE: only support x86_64
HYPERFINE_VERSION = '1.18.0'.freeze

return unless node[:platform] == 'darwin'
github_binary 'hyperfine' do
  repository 'sharkdp/hyperfine'
  version "v#{HYPERFINE_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : '')
  archive "hyperfine-v#{HYPERFINE_VERSION}-x86_64-#{platform}.tar.gz"
  binary_path "hyperfine-v#{HYPERFINE_VERSION}-x86_64-#{platform}/hyperfine"
end
