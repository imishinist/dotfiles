include_role 'base'

%w[
  eza
  starship
  vim
  tmux
  git
  fish
  zellij
  1Password
].each do |cookbook|
  include_cookbook cookbook
end

%w[
  bat
  bctx
  conftest
  direnv
  dlayer
  fd
  fzf
  gh
  hyperfine
  jq
  mitamae
  pet
  ripgrep
  vegeta
  watchexec
].each do |tool|
  include_cookbook "cli/#{tool}"
end

include_cookbook 'emacs' if node[:platform] == 'arch'

%w[go nodejs rust ruby].each do |language|
  include_cookbook language
end

%w[cobra ujsonize usql].each do |tool|
  include_cookbook "cli/#{tool}"
end
