RG_VERSION = '14.1.0'.freeze

cli_binary 'rg' do
  repository 'BurntSushi/ripgrep'
  version RG_VERSION
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  release_name "ripgrep-#{RG_VERSION}-x86_64-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
  tar_options "--strip-components 1"
end
