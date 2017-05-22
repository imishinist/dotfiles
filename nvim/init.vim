if &compatible
    set nocompatible
endif

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'


if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_repo_dir, ':p')
endif

let s:config_path = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME
let s:nvim_path = s:config_path . '/nvim'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml = s:nvim_path . '/dein.toml'
  call dein#load_toml(s:toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

if dein#check_install()
  call dein#install()
endif

let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1

let g:python_host_prog  = '/usr/local/bin/python'
let g:python2_host_prog  = '/usr/local/bin/python2.7'
let g:python3_host_prog  = '/usr/local/bin/python3'


let s:autoload_path = s:nvim_path . '/userautoload'

if !isdirectory(expand(s:autoload_path))
  call system("mkdir -p " . shellescape(s:autoload_path))
endif
runtime! userautoload/*.vim

hi CursorLine guifg=#E19972

set tags+=.git/tags;
set tags+=.tags;

autocmd BufRead,BufNewFile *.slim setfiletype slim

filetype plugin indent on
