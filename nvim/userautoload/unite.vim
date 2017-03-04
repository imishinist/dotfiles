
nnoremap [unite] <Nop>
nmap <C-u> [unite]

let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_limit = 50
let g:unite_source_file_mru_filename_format = ''

nnoremap [unite]u  :<C-u>Unite<Space>
nnoremap <silent> [unite]s :<C-u>Unite source<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]q :<C-u>Unite -no-quit -direction=botright quickfix<CR>

autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-t> :<C-u>Unite jump<CR>
\|  endif

augroup UniteCommand
    autocmd!
    autocmd FileType unite call <SID>unite_my_settings()
augroup END

function! s:unite_my_settings()
    nmap <buffer> <ESC> <Plug>(unite_exit)
    imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
endfunction

