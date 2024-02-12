include_recipe 'recipe_helper'

node.reverse_merge!(
  user: ENV["SUDO_USER"] || ENV["USER"],
  os: run_command('uname').stdout.strip.downcase,
)

include_role node[:platform]