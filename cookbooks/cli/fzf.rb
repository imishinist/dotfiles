FZF_VERSION = '0.52.0'.freeze

cli_binary 'fzf' do
  repository 'junegunn/fzf'
  version FZF_VERSION
  ext = (node[:platform] == 'darwin' ? 'zip' : 'tar.gz')
  release_name "fzf-#{FZF_VERSION}-#{node[:os]}_amd64.#{ext}"
  target_dir "#{ENV['HOME']}/bin"
end
