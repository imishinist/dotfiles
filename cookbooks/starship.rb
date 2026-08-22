STARSHIP_VERSION = '1.22.1'.freeze

cli_binary 'starship' do
  repository 'starship/starship'
  version "v#{STARSHIP_VERSION}"
  arch = node[:arch] == 'x86_64' ? 'x86_64' : 'aarch64'
  platform = node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl'
  release_name "starship-#{arch}-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end

dotfile '.config/starship.toml'
