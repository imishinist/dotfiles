package 'git'

if node[:platform] == 'darwin'
  file(gitconfig = File.join(ENV['HOME'], '.gitconfig')) do
    action :delete
    only_if { File.file?(gitconfig) && !File.symlink?(gitconfig) }
  end
end

dotfile '.gitconfig'
dotfile '.gitignore'

bin_path = "#{ENV['HOME']}/bin"
directory bin_path

link File.join(bin_path, "diff-highlight") do
  case node[:platform]
  when "darwin"
    to "/opt/homebrew/share/git-core/contrib/diff-highlight/diff-highlight"
  else
    to "/usr/share/doc/git/contrib/diff-highlight/diff-highlight"
  end
  user node[:user]
  force true
end
