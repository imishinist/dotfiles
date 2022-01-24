# TODO: nodenv の installがめんどくさい

execute "install nodebrew" do
  command "curl -L https://git.io/nodebrew | perl - setup" do
    user node[:user]
  end
  not_if "test -d #{ENV['HOME']}/.nodebrew"
end

dotfile '.eslintrc'
