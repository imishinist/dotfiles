function fdd
  cd (ghq list --full-path | fzf --layout reverse)
end

function gitignore
  curl -sL https://www.gitignore.io/api/$argv
end

bind \cs pet-select
bind \er '__fzf_insert_reverse_isearch'

function direnv-githook
  set --local dir $(git rev-parse --show-toplevel)
  set --local hook $dir/.git/hooks/post-checkout

  if test -f $hook
    echo "hook already exists: $hook"
  else
    echo "#!/bin/bash" > $hook
    echo "direnv allow ." >> $hook
    echo "hook created"
  end
  chmod +x $hook
end
