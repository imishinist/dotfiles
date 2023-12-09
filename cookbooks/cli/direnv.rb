DIRENV_VERSION = '2.33.0'.freeze

cli_binary 'direnv' do
  repository 'direnv/direnv'
  version "v#{DIRENV_VERSION}"
  release_name "direnv.#{node[:os]}-amd64"
  target_dir "#{ENV['HOME']}/bin"
end