
execute "install volta" do
  command "curl https://get.volta.sh | bash"
  not_if "test -d #{ENV['HOME']}/.volta"
end

dotfile '.eslintrc'
