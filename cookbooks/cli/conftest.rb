CONFTEST_VERSION = '0.52.0'.freeze

cli_binary 'conftest' do
  repository 'open-policy-agent/conftest'
  version "v#{CONFTEST_VERSION}"
  platform, arch = node[:platform] == 'darwin' ? ['Darwin', 'arm64'] : ['Linux', 'x86_64']
  release_name "conftest_#{CONFTEST_VERSION}_#{platform}_#{arch}.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end
