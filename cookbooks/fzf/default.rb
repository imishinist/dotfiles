github_binary 'fzf' do
  repository 'junegunn/fzf'
  version '0.29.0'
  ext = (node[:platform] == 'darwin' ? 'zip' : 'tar.gz')
  archive "fzf-0.29.0-#{node[:os]}_amd64.#{ext}"
  binary_path 'fzf'
end