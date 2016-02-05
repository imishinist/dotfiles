let s:filetypes = ['ruby', 'javascript', 'coffee', 'scss', 'c', 'cpp']

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_ruby_checkers = [ 'rubocop' ]
let g:syntastic_ruby_rubocop_args = '-a'
let g:syntastic_javascript_checkers = [ 'eslint' ]
let g:syntastic_scss_checkers = [ 'scss_lint' ]

let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'passive_filetypes': s:filetypes }

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
hi SyntasticErrorSign ctermfg=160
hi SyntasticWarningSign ctermfg=220


function! s:syntastic()
    SyntasticCheck
    call lightline#update()
    e!
endfunction

command! J call s:syntastic()
