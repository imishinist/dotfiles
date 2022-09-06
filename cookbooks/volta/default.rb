
execute "execute get.volta.sh" do
  command "curl https://get.volta.sh | bash"

  not_if "test -d #{ENV['HOME']}/.volta"
end