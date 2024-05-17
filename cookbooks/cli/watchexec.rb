WATCHEXEC_VERSION = '2.1.1'.freeze

cli_binary 'watchexec' do
  repository 'watchexec/watchexec'
  version "v#{WATCHEXEC_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  arch = node[:arch] == 'x86_64' ? 'x86_64' : 'aarch64'
  release_name "watchexec-#{WATCHEXEC_VERSION}-#{arch}-#{platform}.tar.xz"
  target_dir "#{ENV['HOME']}/bin"
  tar_options "--strip-components 1"
end
