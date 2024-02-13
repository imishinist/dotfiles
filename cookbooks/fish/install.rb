case node[:os]
when 'darwin'
  package 'fish'
when 'linux'
  case node[:platform]
  when 'arch'
    package 'fish'
  when 'ubuntu'
    apt_add_repository "ppa:fish-shell/release-3"
    execute "apt update"
    package 'fish'
  end
end
