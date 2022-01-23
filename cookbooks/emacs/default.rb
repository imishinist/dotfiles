directory "#{ENV['HOME']}/.config" do
  owner node[:user]
end

dotfile '.config/emacs'
