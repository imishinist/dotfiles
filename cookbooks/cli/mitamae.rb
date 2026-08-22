MITAMAE_VERSION = '1.14.1'.freeze

cli_binary 'mitamae' do
  repository 'itamae-kitchen/mitamae'
  version "v#{MITAMAE_VERSION}"
  platform = node[:platform] == 'darwin' ? 'darwin' : 'linux'
  arch = node[:arch] == 'x86_64' ? 'x86_64' : 'aarch64'
  release_name "mitamae-#{arch}-#{platform}.tar.gz"
  bin_path "mitamae-#{arch}-#{platform}"
  target_dir "#{ENV['HOME']}/bin"
end
