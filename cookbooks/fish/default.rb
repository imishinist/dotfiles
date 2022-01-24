# TODO: for ubuntu

[
  "#{ENV['HOME']}/.config",
  "#{ENV['HOME']}/.config/fish",
  "#{ENV['HOME']}/.config/fish/completions",
  "#{ENV['HOME']}/.config/fish/functions",
].each do |dir|
  directory dir do
    owner node[:user]
  end
end

case node[:os]
when 'darwin'
  package 'fish'
when 'linux'
  apt_add_repository "ppa:fish-shell/release-3"
  execute "apt update"
  package 'fish'
end

dotfile '.config/fish/config.fish'
dotfile '.config/fish/fish_variables'
dotfile '.config/fish/functions/common.fish'
dotfile '.config/fish/functions/fish_prompt.fish'

execute "install fisherman" do
  command "echo \"curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher\" | fish"
  not_if "echo \"type fisher >/dev/null 2>&1\" | fish"
end

define :fisher do
  execute "echo \"fisher install #{params[:name]}\" | fish" do
    not_if "echo \"fisher list\" | fish | grep \"^#{params[:name]}\""
  end
end

dotfile '.config/fish/completions/atcoder-tools.fish'