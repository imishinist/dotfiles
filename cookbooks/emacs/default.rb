directory "#{ENV['HOME']}/.config" do
  owner node[:user]
end
directory "#{ENV['HOME']}/.config/emacs" do
  owner node[:user]
end

case node[:os]
when "darwin"
  package "emacs"
when "linux"
  snap "emacs" do
    classic true
  end
end

dotfile '.config/emacs/init.el'
