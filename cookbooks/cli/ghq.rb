GHQ_VERSION = '1.6.1'.freeze

cli_binary 'ghq' do
  repository 'x-motemen/ghq'
  version "v#{GHQ_VERSION}"
  release_name "ghq_#{node[:os]}_amd64.zip"
  target_dir "#{ENV['HOME']}/bin"
  tar_options '--strip-components 1'
end
