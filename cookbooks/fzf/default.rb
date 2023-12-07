FZF_VERSION = '0.44.1'.freeze

github_binary 'fzf' do
  repository 'junegunn/fzf'
  version FZF_VERSION
  ext = (node[:platform] == 'darwin' ? 'zip' : 'tar.gz')
  archive "fzf-#{FZF_VERSION}-#{node[:os]}_amd64.#{ext}"
  binary_path 'fzf'
end