RG_VERSION = '14.1.1'.freeze

cli_binary 'rg' do
  repository 'BurntSushi/ripgrep'
  version RG_VERSION
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  arch = node[:arch] == 'x86_64' ? 'x86_64' : 'aarch64'
  platform = 'unknown-linux-gnu' if node[:platform] != 'darwin' && arch == 'aarch64'
  release_name "ripgrep-#{RG_VERSION}-#{arch}-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
  tar_options "--strip-components 1"
end
