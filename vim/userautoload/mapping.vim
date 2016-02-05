
set pastetoggle=<F9>
nnoremap <F9> :set paste!<CR>:set paste?<CR>

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

inoremap <C-j> <ESC>

nnoremap <silent> <F10> mpgg"*yG`p:delmarks p<CR>
