
EZA_VERSION = '0.18.15'.freeze
case node[:os]
when "linux"
  cli_binary 'eza' do
    repository 'eza-community/eza'
    version "v#{EZA_VERSION}"
    release_name "eza_x86_64-unknown-linux-musl.tar.gz"
    target_dir "#{ENV['HOME']}/bin"
  end
else
  brew 'eza'
end
