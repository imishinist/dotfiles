DIRENV_VERSION = '2.35.0'.freeze

cli_binary 'direnv' do
  repository 'direnv/direnv'
  version "v#{DIRENV_VERSION}"
  arch = node[:arch] == 'x86_64' ? 'amd64' : 'arm64'
  release_name "direnv.#{node[:os]}-#{arch}"
  target_dir "#{ENV['HOME']}/bin"
end

dotfile '.config/direnv' do
  source '.config/direnv'
end
