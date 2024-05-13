MITAMAE_VERSION = '1.14.1'.freeze

cli_binary 'mitamae' do
  repository 'itamae-kitchen/mitamae'
  version "v#{MITAMAE_VERSION}"
  platform, arch = node[:platform] == 'darwin' ? ['darwin', 'aarch64'] : ['linux', 'x86_64']
  release_name "mitamae-#{arch}-#{platform}.tar.gz"
  bin_path "mitamae-#{arch}-#{platform}"
  target_dir "#{ENV['HOME']}/bin"
end
