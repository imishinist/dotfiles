JQ_VERSION = '1.7'.freeze

cli_binary 'jq' do
  repository 'stedolan/jq'
  version "jq-#{JQ_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'osx-amd64' : 'linux64')
  release_name "jq-#{platform}"
  target_dir "#{ENV['HOME']}/bin"
end