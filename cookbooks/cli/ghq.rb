GHQ_VERSION = '1.8.0'.freeze

cli_binary 'ghq' do
  repository 'x-motemen/ghq'
  version "v#{GHQ_VERSION}"
  arch = node[:arch] == 'x86_64' ? 'amd64' : 'arm64'
  archive_name = "ghq_#{node[:os]}_#{arch}"
  release_name "#{archive_name}.zip"
  target_dir "#{ENV['HOME']}/bin"
  bin_path "#{archive_name}/ghq"
end
