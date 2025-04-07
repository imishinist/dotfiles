include_role 'base'
include_cookbook 'git'
include_cookbook 'zsh'

include_cookbook 'brew'
brew 'pkg-config'
brew 'coreutils'
brew 'moreutils'
brew 'gnuplot'
brew 'gnupg'
brew 'gnu-sed'
brew 'gnu-tar'
brew 'htop'
brew 'mkcert'
brew 'protobuf'
brew 'qemu'

include_cookbook 'alacritty'
include_cookbook 'eza'
include_cookbook 'fish/install'
include_cookbook 'fish'
include_cookbook 'starship'
include_cookbook 'vim'
include_cookbook 'emacs'
include_cookbook 'tmux/install'
include_cookbook 'tmux'
include_cookbook 'multipass'
include_cookbook 'git'
include_cookbook 'karabiner'
include_cookbook 'zellij'
include_cookbook '1Password'

# cli tools(not use brew)
include_cookbook 'cli/bat'
include_cookbook 'cli/bctx'
include_cookbook 'cli/conftest'
include_cookbook 'cli/direnv'
include_cookbook 'cli/dlayer'
include_cookbook 'cli/fd'
include_cookbook 'cli/fzf'
include_cookbook 'cli/gh'
include_cookbook 'cli/ghq'
include_cookbook 'cli/hyperfine'
include_cookbook 'cli/jq'
include_cookbook 'cli/mitamae'
include_cookbook 'cli/pet'
include_cookbook 'cli/ripgrep'
include_cookbook 'cli/vegeta'
include_cookbook 'cli/watchexec'

# lang
include_cookbook 'go'
include_cookbook 'nodejs'
include_cookbook 'rust'
include_cookbook 'ruby'
include_cookbook 'python'

# go tools
include_cookbook 'cli/cobra'
include_cookbook 'cli/ujsonize'
include_cookbook 'cli/usql'
