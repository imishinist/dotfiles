
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \     'windows' : 'tools\\update-dll-mingw',
            \     'cygwin' : 'make -f make_cygwin.mak',
            \     'mac' : 'make',
            \     'linux' : 'make',
            \     'unix' : 'gmake',
            \    },
            \ }

" Filter
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'kmnk/vim-unite-giti'

" AutoComplete
NeoBundle 'Shougo/neocomplete'

" Snippet
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'

" Color Scheme
NeoBundle 'tomasr/molokai'

" Syntax Highlight
NeoBundle 'vim-scripts/nginx.vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'hail2u/vim-css3-syntax'

" StatusLine
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'rking/ag.vim'
NeoBundle 'tpope/vim-fugitive'

NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'vim-scripts/ruby-matchit'

NeoBundle 'scrooloose/syntastic'

NeoBundle 'thinca/vim-quickrun'

NeoBundleLazy 'Blackrush/vim-gocode', {"autoload": {"filetypes": ['go']}}

NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'autoload' : {
  \ 'insert' : 1,
  \ 'filetypes': 'ruby',
  \ }}

NeoBundle 'tpope/vim-rails'
NeoBundle 'skwp/vim-rspec'


call neobundle#end()
filetype plugin indent on

NeoBundleCheck

