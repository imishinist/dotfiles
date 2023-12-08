GHQ_VERSION = '1.4.2'.freeze

github_binary 'ghq' do
  repository 'x-motemen/ghq'
  version "v#{GHQ_VERSION}"
  archive "ghq_#{node[:os]}_amd64.zip"
  binary_path "ghq_#{node[:os]}_amd64/ghq"
end

include_cookbook 'git'
