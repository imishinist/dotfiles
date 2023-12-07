function fdd
  cd (ghq list --full-path | fzf --layout reverse)
end

function gitignore
  curl -sL https://www.gitignore.io/api/$argv
end