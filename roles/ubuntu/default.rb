include_role 'base'

package "build-essential"
package "pkg-config"
package "openssl"

include_cookbook 'eza'
include_cookbook 'fish'
include_cookbook 'starship'
include_cookbook 'vim'
include_cookbook 'emacs'
include_cookbook 'tmux'
include_cookbook 'multipass'
include_cookbook 'git'

# cli tools(not use brew)
include_cookbook 'cli/bat'
include_cookbook 'cli/bctx'
include_cookbook 'cli/direnv'
include_cookbook 'cli/dlayer'
include_cookbook 'cli/fd'
include_cookbook 'cli/fzf'
include_cookbook 'cli/gh'
include_cookbook 'cli/ghq'
include_cookbook 'cli/hyperfine'
include_cookbook 'cli/jq'
include_cookbook 'cli/ripgrep'
include_cookbook 'cli/vegeta'

include_cookbook 'nodejs'
include_cookbook 'rust'
include_cookbook 'ruby'
