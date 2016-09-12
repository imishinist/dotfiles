
set termguicolors

set shiftwidth=4
set tabstop=4
set softtabstop=4
set cindent

set clipboard+=unnamedplus

set number

augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme solarized

if has('persistent_undo')
  let &undodir = expand('~/.cache/nvim/undo')
  if !isdirectory(&undodir)
    call system("mkdir -p " . shellescape(&undodir))
  endif
  set undofile
endif
