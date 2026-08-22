set nocompatible

set number
set ruler
set showcmd

set autoindent
set smartindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

set ignorecase
set smartcase
set hlsearch

set backspace=indent,eol,start
set encoding=utf-8
set fileencoding=utf-8

if has('clipboard')
  set clipboard+=unnamedplus
endif

if has('persistent_undo')
  let &undodir = expand('~/.cache/vim/undo')
  if !isdirectory(&undodir)
    call mkdir(&undodir, 'p')
  endif
  set undofile
endif

augroup vimrc
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line('$') | execute "normal! g`\"" | endif
augroup END

syntax enable
filetype plugin indent on
