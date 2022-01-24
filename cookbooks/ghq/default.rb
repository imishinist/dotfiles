github_binary 'ghq' do
  repository 'x-motemen/ghq'
  version 'v1.2.1'
  archive "ghq_#{node[:os]}_amd64.zip"
  binary_path "ghq_#{node[:os]}_amd64/ghq"
end

include_cookbook 'git'