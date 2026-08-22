JQ_VERSION = '1.7.1'.freeze

cli_binary 'jq' do
  repository 'jqlang/jq'
  version "jq-#{JQ_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'macos' : 'linux')
  arch = (node[:arch] == 'x86_64' ? 'amd64' : 'arm64')
  release_name "jq-#{platform}-#{arch}"
  target_dir "#{ENV['HOME']}/bin"
end
