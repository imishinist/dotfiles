BAT_VERSION = '0.24.0'.freeze

cli_binary 'bat' do
  repository 'sharkdp/bat'
  version "v#{BAT_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  release_name "bat-v#{BAT_VERSION}-x86_64-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
  tar_options '--strip-components 1'
end