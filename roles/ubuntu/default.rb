include_role 'base'

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

include_cookbook 'nodejs'

include_cookbook 'ruby'

include_cookbook 'rust'
# cargo 'cargo-edit'