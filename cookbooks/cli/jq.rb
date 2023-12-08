JQ_VERSION = '1.7'.freeze

github_binary 'jq' do
  repository 'stedolan/jq'
  version "jq-#{JQ_VERSION}"
  ext = (node[:platform] == 'darwin' ? 'zip' : 'tar.gz')
  platform = (node[:platform] == 'darwin' ? 'osx-amd64' : 'linux64')
  archive "jq-#{platform}"
  binary_path "jq-#{platform}"
end