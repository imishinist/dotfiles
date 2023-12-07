include_role 'base'

include_cookbook 'brew'
brew 'pkg-config'
brew 'coreutils'
brew 'moreutils'
brew 'gnu-sed'
brew 'gnupg'
brew 'protobuf'
brew 'bat'
brew 'fd'

include_cookbook 'emacs'
include_cookbook 'fish'

# cli tools
include_cookbook 'direnv'
include_cookbook 'fzf'
include_cookbook 'gh'
include_cookbook 'ghq'
include_cookbook 'jq'
include_cookbook 'ripgrep'
include_cookbook 'vegeta'
include_cookbook 'dlayer'
include_cookbook 'bctx'

include_cookbook 'volta'
include_cookbook 'multipass'
include_cookbook 'tmux'
include_cookbook 'vim'

include_cookbook 'nodejs'
include_cookbook 'rust'