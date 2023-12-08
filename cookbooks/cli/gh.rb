# NOTE: only support x86_64
GH_VERSION = '2.40.0'.freeze

github_binary 'gh' do
  repository 'cli/cli'
  version "v#{GH_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'macOS' : 'linux')
  archive "gh_#{GH_VERSION}_#{platform}_amd64.zip"
  binary_path "gh_#{GH_VERSION}_#{platform}_amd64/bin/gh"
end