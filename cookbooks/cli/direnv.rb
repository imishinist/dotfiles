DIRENV_VERSION = '2.33.0'.freeze

github_binary 'direnv' do
  repository 'direnv/direnv'
  version "v#{DIRENV_VERSION}"
  archive "direnv.#{node[:os]}-amd64"
  binary_path "direnv.#{node[:os]}-amd64"
end