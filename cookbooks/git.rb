package 'git'

DIFF_SO_FANCY_VERSION = '1.4.4'.freeze

cli_binary 'diff-so-fancy' do
  repository 'so-fancy/diff-so-fancy'
  version "v#{DIFF_SO_FANCY_VERSION}"
  release_name "diff-so-fancy"
  target_dir "#{ENV['HOME']}/bin"
end

dotfile '.gitconfig'
dotfile '.gitignore'
