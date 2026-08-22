GHQ_VERSION = '1.8.0'.freeze

cli_binary 'ghq' do
  repository 'x-motemen/ghq'
  version "v#{GHQ_VERSION}"
  arch = node[:arch] == 'x86_64' ? 'amd64' : 'arm64'
  release_name "ghq_#{node[:os]}_#{arch}.zip"
  target_dir "#{ENV['HOME']}/bin"
  tar_options '--strip-components 1'
end
