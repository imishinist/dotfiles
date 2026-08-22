GH_VERSION = '2.69.0'.freeze

cli_binary 'gh' do
  repository 'cli/cli'
  version "v#{GH_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'macOS' : 'linux')
  arch = (node[:arch] == 'x86_64' ? 'amd64' : 'arm64')
  ext = (node[:platform] == 'darwin' ? 'zip' : 'tar.gz')
  release_name "gh_#{GH_VERSION}_#{platform}_#{arch}.#{ext}"
  target_dir "#{ENV['HOME']}/bin"
  bin_path "bin/gh"
  tar_options '--strip-components 1'
end
