
case node[:os]
when "linux"
  EZA_VERSION = '0.16.3'.freeze

  cli_binary 'eza' do
    repository 'eza-community/eza'
    version "v#{EZA_VERSION}"
    release_name "eza_x86_64_unknown-linux-musl.tar.gz"
    target_dir "#{ENV['HOME']}/bin"
  end
else
  brew 'eza'
end
