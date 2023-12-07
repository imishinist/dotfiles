# NOTE: only support x86_64
rg_version = '14.0.3'.freeze

github_binary 'rg' do
  repository 'BurntSushi/ripgrep'
  version rg_version
  platform = (node[:platform] == 'darwin' ? 'apple-darwin' : 'unknown-linux-musl')
  archive "ripgrep-#{rg_version}-x86_64-#{platform}.tar.gz"
  binary_path "ripgrep-#{rg_version}-x86_64-#{platform}/rg"
end