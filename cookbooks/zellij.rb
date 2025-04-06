
ZELLIJ_VERSION = '0.42.1'.freeze

cli_binary 'zellij' do
  repository 'zellij-org/zellij'
  version "v#{ZELLIJ_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  arch = (node[:platform] == 'x86_64' ? 'x86_64' : 'aarch64')
  release_name "zellij-#{arch}-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end

dotfile '.config/zellij/config.kdl'
