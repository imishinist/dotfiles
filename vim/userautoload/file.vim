
function! s:ruby_setting()
    set ts=2 sw=2 sts=2
endfunction

function! s:php_setting()
endfunction

function! s:html_setting()
    set ts=2 sw=2 sts=2
endfunction

autocmd Filetype ruby call s:ruby_setting()
autocmd FileType php call s:php_setting()
autocmd FileType html call s:html_setting()

autocmd BufWritePre *.go Fmt

