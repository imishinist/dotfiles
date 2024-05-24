include_recipe '../../lib/recipe_helper'
node.reverse_merge!(
  os: run_command('uname').stdout.strip.downcase,
)

include_role 'base'

package "pkg-config"
package "openssl"
package "unzip"

include_cookbook 'fish/install'
include_cookbook 'emacs'
include_cookbook 'tmux/install'
