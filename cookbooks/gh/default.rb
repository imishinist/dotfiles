# NOTE: only support x86_64
gh_version = '2.4.0'

github_binary 'gh' do
  repository 'cli/cli'
  version "v#{gh_version}"
  platform = (node[:platform] == 'darwin' ? 'macOS' : 'linux')
  archive "gh_#{gh_version}_#{platform}_amd64.tar.gz"
  binary_path "gh_#{gh_version}_#{platform}_amd64/bin/gh"
end