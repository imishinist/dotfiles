# NOTE: only support x86_64
BAT_VERSION = '0.24.0'.freeze

github_binary 'bat' do
  repository 'sharkdp/bat'
  version "v#{BAT_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  archive "bat-v#{BAT_VERSION}-x86_64-#{platform}.tar.gz"
  binary_path "bat-v#{BAT_VERSION}-x86_64-#{platform}/bat"
end
