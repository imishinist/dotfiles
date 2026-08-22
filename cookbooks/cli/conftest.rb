CONFTEST_VERSION = '0.52.0'.freeze

cli_binary 'conftest' do
  repository 'open-policy-agent/conftest'
  version "v#{CONFTEST_VERSION}"
  platform = node[:platform] == 'darwin' ? 'Darwin' : 'Linux'
  arch = node[:arch] == 'x86_64' ? 'x86_64' : 'arm64'
  release_name "conftest_#{CONFTEST_VERSION}_#{platform}_#{arch}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end
