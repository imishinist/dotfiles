FD_VERSION = '10.2.0'.freeze

cli_binary 'fd' do
  repository 'sharkdp/fd'
  version "v#{FD_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  arch = node[:arch] == 'x86_64' ? 'x86_64' : 'aarch64'
  release_name "fd-v#{FD_VERSION}-#{arch}-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
  tar_options '--strip-components 1'
end
