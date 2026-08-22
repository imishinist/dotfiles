
execute "install volta" do
  command "curl -fsSL https://get.volta.sh | bash -s -- --skip-setup"
  not_if "test -x #{ENV['HOME']}/.volta/bin/volta"
end

dotfile '.eslintrc'
