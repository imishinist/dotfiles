# TODO: for ubuntu

[
  "#{ENV['HOME']}/.config",
  "#{ENV['HOME']}/.config/fish",
  "#{ENV['HOME']}/.config/fish/completions",
  "#{ENV['HOME']}/.config/fish/functions",
  "#{ENV['HOME']}/.config/fish/conf.d",
].each do |dir|
  directory dir
end

puts node[:os]
dotfile '.config/fish/config.local.fish' do
  case node[:os]
  when "darwin"
    source ".config/fish/config.darwin.fish"
  when "linux"
    source ".config/fish/config.linux.fish"
  else
    raise NotImplmentedError
  end
end

dotfile '.config/fish/config.fish'
dotfile '.config/fish/conf.d/common.fish'
dotfile '.config/fish/functions/pet.fish'
dotfile '.config/fish/functions/__fzf_insert_reverse_isearch.fish'

dotfile '.config/fish/conf.d/atcoder-tools.fish'

dotfile_copy '.config/fish/fish_plugins'
dotfile_copy '.config/fish/functions/fish_prompt.fish'

execute "install fisherman" do
  command 'echo "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher" | fish'
  not_if "echo \"type fisher >/dev/null 2>&1\" | fish"
end

execute "echo \"fisher update\" | fish" do
  action :nothing
  subscribes :run, "remote_file[.config/fish/fish_plugins]"
end
