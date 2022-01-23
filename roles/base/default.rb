directory "#{ENV['HOME']}/bin" do
  owner node[:user]
end

include_cookbook 'functions'
include_cookbook 'git'
include_cookbook 'zsh'