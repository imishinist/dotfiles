PET_VERSION = '1.0.1'.freeze

cli_binary 'pet' do
  repository 'knqyf263/pet'
  version "v#{PET_VERSION}"
  platform = (node[:platform] == 'darwin' ? 'darwin' : 'linux')
  release_name "pet_#{PET_VERSION}_#{platform}_amd64.tar.gz"
  target_dir "#{ENV['HOME']}/bin"
end
