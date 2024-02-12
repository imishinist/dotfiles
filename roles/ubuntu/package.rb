include_recipe '../../lib/recipe_helper'
include_role 'base'

include_cookbook 'git'
include_cookbook 'zsh'

package "build-essential"
package "pkg-config"
package "openssl"
package "unzip"

include_cookbook 'fish'
include_cookbook 'emacs'
