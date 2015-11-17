
set backspace=indent,eol,start

inoremap <C-j> <ESC>

if has('persistent_undo')
  set undodir=~/.vim/undo/
  set undofile
endif

set expandtab
set ruler
set formatoptions=lmoq
set showcmd
set laststatus=2
set cmdheight=2
set noshowmode

set number
set showmatch
set smarttab

set incsearch
set wrapscan
set smartcase
set ignorecase
set nohlsearch

set wildmenu wildmode=list:full
set autoread
set foldmethod=marker

set nowrap

set tabstop=4 shiftwidth=4
set cindent

nnoremap <silent> <F10> mpgg"*yG`p:delmarks p<CR>

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*


