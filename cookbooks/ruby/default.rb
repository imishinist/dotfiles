directory "#{ENV['HOME']}/.bundle" do
  owner node[:user]
end

dotfile '.bundle/config'
dotfile '.gemrc'