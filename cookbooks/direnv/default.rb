github_binary 'direnv' do
  repository 'direnv/direnv'
  version 'v2.33.0'
  archive "direnv.#{node[:os]}-amd64"
  binary_path "direnv.#{node[:os]}-amd64"
end