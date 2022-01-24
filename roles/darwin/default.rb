include_role 'base'

include_cookbook 'brew'
brew 'pkg-config'
brew 'coreutils'
brew 'moreutils'
brew 'gnu-sed'
brew 'gnupg'
brew 'protobuf'

include_cookbook 'emacs'
include_cookbook 'direnv'
include_cookbook 'fish'
fisher 'daenney/pyenv'

include_cookbook 'fzf'
fisher 'jethrokuan/fzf'

include_cookbook 'gh'
include_cookbook 'ghq'
include_cookbook 'jq'
include_cookbook 'ripgrep'
include_cookbook 'tmux'
include_cookbook 'vim'

include_cookbook 'go'
goinstall 'golang.org/x/tools/cmd/goimports'
goinstall 'github.com/go-delve/delve/cmd/dlv'
goinstall 'github.com/golang/protobuf/protoc-gen-go'
goinstall 'github.com/tsenart/vegeta'
goinstall 'github.com/orisano/dlayer'
goinstall 'github.com/orisano/bctx'
goinstall 'github.com/spf13/cobra'

include_cookbook 'nodejs'

include_cookbook 'ruby'

include_cookbook 'rust'
cargo 'cargo-edit'