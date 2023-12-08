# NOTE: only support x86_64
FD_VERSION = '8.7.1'.freeze

return unless node[:platform] == 'darwin'

github_binary 'fd' do
  repository 'sharkdp/fd'
  version "v#{FD_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : '')
  archive "fd-v#{FD_VERSION}-x86_64-#{platform}.tar.gz"
  binary_path "fd-v#{FD_VERSION}-x86_64-#{platform}/fd"
end
