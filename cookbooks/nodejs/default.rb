
execute "install volta" do
  command "curl https://get.volta.sh | bash"
  user node[:user]
  not_if "test -d #{ENV['HOME']}/.volta"
end

dotfile '.eslintrc'
