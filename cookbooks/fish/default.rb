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

dotfile '.config/fish/config.local.fish' do
  case node[:os]
  when "darwin"
    source ".config/fish/config.darwin.fish"
  when "linux"
    source ".config/fish/config.linux.fish"
  else
    raise NotImplementedError
  end
end

touch '.config/fish/config.custom.fish'

dotfile '.config/fish/config.fish'
dotfile '.config/fish/conf.d/common.fish'
dotfile '.config/fish/conf.d/pet.fish'
dotfile '.config/fish/functions/__fzf_insert_reverse_isearch.fish'

dotfile '.config/fish/conf.d/atcoder-tools.fish'

dotfile_copy '.config/fish/fish_plugins'
dotfile_copy '.config/fish/functions/fish_prompt.fish'

execute "install fisherman" do
  command "fish -c 'curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher install jorgebucaran/fisher'"
  not_if "fish -c 'type -q fisher'"
end

execute "echo \"fisher update\" | fish" do
  action :nothing
  subscribes :run, "remote_file[.config/fish/fish_plugins]"
end
