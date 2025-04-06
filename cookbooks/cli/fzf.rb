FZF_VERSION = '0.61.1'.freeze

cli_binary 'fzf' do
  repository 'junegunn/fzf'
  version "v#{FZF_VERSION}"
  arch = node[:arch] == 'x86_64' ? 'amd64' : 'arm64'
  release_name "fzf-#{FZF_VERSION}-#{node[:os]}_#{arch}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end
