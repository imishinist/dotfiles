DIRENV_VERSION = '2.35.0'.freeze

cli_binary 'direnv' do
  repository 'direnv/direnv'
  version "v#{DIRENV_VERSION}"
  release_name "direnv.#{node[:os]}-amd64"
  target_dir "#{ENV['HOME']}/bin"
end

dotfile '.config/direnv' do
  source '.config/direnv'
end
