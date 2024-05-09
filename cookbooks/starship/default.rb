STARSHIP_VERSION = '1.18.2'.freeze

cli_binary 'starship' do
  repository 'starship/starship'
  version "v#{STARSHIP_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'aarch64-apple-darwin' : 'x86_64-unknown-linux-musl')
  release_name "starship-#{platform}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end

dotfile '.config/starship.toml'
