
function pet-select
  set -l query (commandline)
  pet search --query "$query" $argv | read cmd
  commandline "$cmd"
  commandline -f repaint
end

