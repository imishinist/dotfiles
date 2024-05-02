
function __fzf_insert_reverse_isearch
    history merge
    history -z | eval (__fzfcmd) --read0 --print0 --tiebreak=index --toggle-sort=ctrl-r $FZF_DEFAULT_OPTS $FZF_REVERSE_ISEARCH_OPTS | read -lz result
    and commandline -i -- $result
    commandline -f repaint
end
