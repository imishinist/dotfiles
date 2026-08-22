EZA_VERSION = '0.21.0'.freeze

case node[:os]
when "linux"
  cli_binary 'eza' do
    repository 'eza-community/eza'
    version "v#{EZA_VERSION}"
    target = node[:arch] == 'x86_64' ? 'x86_64-unknown-linux-musl' : 'aarch64-unknown-linux-gnu'
    release_name "eza_#{target}.tar.gz"
    target_dir "#{ENV['HOME']}/bin"
  end
else
  brew 'eza'
end
