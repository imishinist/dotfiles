include_recipe '../../lib/recipe_helper'
node.reverse_merge!(
  os: run_command('uname').stdout.strip.downcase,
)

include_role 'base'

include_cookbook 'git'
include_cookbook 'zsh'

package "build-essential"
package "pkg-config"
package "openssl"
package "unzip"

include_cookbook 'fish/install'
include_cookbook 'emacs'
