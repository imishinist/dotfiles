function fd
  cd (ghq list --full-path | fzf --layout reverse)
end