set nocompatible
syntax on

if !isdirectory("~/.vim/")
  call system("mkdir -p ~/.vim/")
endif

if isdirectory("~/.vim/userautoload")
  call system("mkdir -p ~/.vim/userautoload")
endif

set runtimepath^=~/.vim/
runtime! userautoload/*.vim

set t_Co=256

colorscheme molokai
