FD_VERSION = '10.1.0'.freeze

cli_binary 'fd' do
  repository 'sharkdp/fd'
  version "v#{FD_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  release_name "fd-v#{FD_VERSION}-x86_64-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
  tar_options '--strip-components 1'
end
