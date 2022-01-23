set nocompatible
syntax on

" 256色に対応
set t_Co=256

if !isdirectory("~/.vim/")
  call system("mkdir -p ~/.vim/")
endif

" 別バッファに移動するときに保存しなくて良い
set hidden
set autoread

" バックスペースで削除できるものを指定
" indent: 行頭の空白
" eol   : 改行
" start : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

au WinLeave * set nocursorline
au WinEnter * set cursorline
set cursorline

" Undoディレクトリを指定{{{
if has('persistent_undo')
  if !isdirectory("~/.vim/undo")
    call system("mkdir -p ~/.vim/undo")
  endif
  set undodir=~/.vim/undo/
  set undofile
endif
"}}}

" Swapディレクトリを指定{{{
if !isdirectory("~/.vim/swap")
    call system("mkdir -p ~/.vim/swap")
endif
set directory=~/.vim/swap
"}}}

" Backupディレクトリを指定{{{
if !isdirectory("~/.vim/backup")
    call system("mkdir -p ~/.vim/backup")
endif
set backup
set backupdir=~/.vim/backup
"}}}

" 検索関係{{{
" コマンド、検索パターンを100個まで履歴に残す
set history=100
" 大文字小文字を区別しない
set ignorecase
" 大文字が含まれている場合は区別する
set smartcase
" 最後まで検索したら先頭に戻る
set wrapscan
" インクリメンタルサーチを使わない
set noincsearch
set nohlsearch
"}}}

" 表示関係{{{
set title
set ruler
set number
set showcmd
set laststatus=2
set showmatch
set matchtime=2
set wildmenu wildmode=list:full
set nowrap
set cmdheight=2
set formatoptions=lmoq
set noshowmode

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
"}}}

" インデント{{{
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set cindent
set smarttab
"}}}

" 文字コード{{{
if exists('&ambiwidth')
    set ambiwidth=double
endif
"}}}

" オートコマンド{{{
if has("autocmd")
    " ファイルタイプ別インデント、プラグインを有効にする
    filetype plugin indent on

    " カーソル位置を記憶する
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
    augroup BinaryXXD
      autocmd!
      autocmd BufReadPre *.bin let &binary = 1
      autocmd BufReadPost * if &binary | silent %!xxd -g 1
      autocmd BufReadPost * set ft=xxd | endif
      autocmd BufWritePre * if &binary | %!xxd -r
      autocmd BufWritePre * endif
      autocmd BufWritePost * if &binary | silent %!xxd -g 1
      autocmd BufWritePost * set nomod | endif
    augroup END
endif
"}}}

" Marker{{{
set foldmethod=marker
"}}}

" Lang setting{{{
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
"}}}

" tags{{{
if has("path_extra")
  set tags+=tags;
endif
"}}}

" Mapping{{{
set pastetoggle=<F9>
nnoremap <F9> :set paste!<CR>:set paste?<CR>

nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"

inoremap <C-j> <ESC>

nnoremap <silent> <F10> mpgg"*yG`p:delmarks p<CR>
"}}}

" NeoBundle{{{
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

NeoBundle 'thinca/vim-ref', {
            \ 'commands' : 'Ref',
            \ 'unite_sources' : 'ref',
            \ }

NeoBundleLazy 'Shougo/unite.vim', {
            \ 'commands' : [{ 'name' : 'Unite',
            \ 'complete' : 'customlist,unite#complete_source'},
            \ 'UniteWithCursorWord', 'UniteWithInput']
            \ }

" Filter
NeoBundleLazy 'Shougo/vimfiler', {
            \ "autoload" : { "commands" : ["VimFilerBufferDir"] },
            \ "depends" : [ "Shougo/unite.vim" ]
            \ }
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'kmnk/vim-unite-giti'
NeoBundle 'tsukkee/unite-tag'
NeoBundle 'Shougo/unite-outline'

if has('lua') && (v:version > 703 || (v:version == 703 && has('patch885')))
    " AutoComplete
    NeoBundle 'Shougo/neocomplete', {
                \ "autoload" : { "insert" : 1 }
                \ }

    " Snippet
    NeoBundle 'Shougo/neosnippet', {
                \ "autoload" : { "insert" : 1 }
                \ }
    NeoBundle 'Shougo/neosnippet-snippets', {
                \ "autoload" : { "insert" : 1 },
                \ "depends" : [ "Shougo/neosnippet" ]
                \ }
endif

" Color Scheme
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'

" StatusLine
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'rking/ag.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'rhysd/committia.vim'

" NeoBundle 'vim-scripts/AnsiEsc.vim'

" NeoBundle 'scrooloose/syntastic'

" NeoBundle 'thinca/vim-quickrun'

"NeoBundleLazy 'supermomonga/neocomplete-rsense.vim', { 'autoload' : {
"  \ 'insert' : 1,
"  \ 'filetypes': 'ruby',
"  \ }}

" Syntax Highlight
NeoBundleLazy 'vim-scripts/nginx.vim', {
            \ "autoload" : { "filetypes" : ["nginx"] }
            \ }
NeoBundleLazy 'kchmck/vim-coffee-script', {
            \ "autoload" : { "filetypes" : ["coffee"] }
            \ }
NeoBundle 'hail2u/vim-css3-syntax', {
            \ "autoload" : { "filetypes" : ["css"] }
            \ }

NeoBundleLazy 'tpope/vim-endwise', {
            \ "autoload" : { "insert" : 1 }
            \ }
NeoBundleLazy 'Townk/vim-autoclose', {
            \ "autoload" : { "insert" : 1 }
            \ }

NeoBundleLazy 'isRuslan/vim-es6', {
            \ "autoload" : { "filetypes" : ["js", "es6"] }
            \ }

NeoBundleLazy 'slim-template/vim-slim', {
            \ "autoload" : { "filetypes" : ["slim"] }
            \ }

NeoBundleLazy 'vim-ruby/vim-ruby', {
            \ "autoload" : { "filetypes" : ["ruby"] }
            \ }
NeoBundleLazy 'vim-scripts/ruby-matchit', {
            \ "autoload" : { "filetypes" : ["ruby"] }
            \ }
NeoBundleLazy 'tpope/vim-rails', {
            \ "autoload" : { "filetypes" : ["ruby"] }
            \ }
NeoBundleLazy 'skwp/vim-rspec', {
            \ "autoload" : { "filetypes" : ["ruby"] }
            \ }
NeoBundleLazy 'basyura/unite-rails', {
            \ "autoload" : { "filetypes" : ["ruby"] }
            \ }

NeoBundleLazy 'Blackrush/vim-gocode', {
            \ "autoload" : { "filetypes" : ["go"] }
            \ }
autocmd BufWritePre *.go Fmt

call neobundle#end()
filetype plugin indent on

NeoBundleCheck
"}}}

" Unite{{{
nnoremap [unite] <Nop>
nmap <Space>u [unite]

let g:unite_enable_start_insert = 1
let g:unite_source_file_mru_limit = 50
let g:unite_source_file_mru_filename_format = ''

nnoremap <silent> [unite]s :<C-u>Unite source<CR>
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file file/new<CR>
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]g :<C-u>Unite -silent menu:git<CR>
nnoremap <silent> [unite]q :<C-u>Unite -no-quit -direction=botright quickfix<CR>

autocmd BufEnter *
\   if empty(&buftype)
\|      nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
\|  endif

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
    for source in unite#get_current_unite().sources
        let source_name = substitute(source.name, '[-/]', '_', 'g')
        if !empty(source_name) && has_key(s:unite_hooks, source_name)
            call s:unite_hooks[source_name]()
        endif
    endfor
endfunction

let s:unite_hooks = {}

function! s:unite_hooks.giti_status()
	nnoremap <silent><buffer><expr>gM unite#do_action('ammend')
	nnoremap <silent><buffer><expr>gm unite#do_action('commit')
	nnoremap <silent><buffer><expr>ga unite#do_action('stage')
	nnoremap <silent><buffer><expr>gc unite#do_action('checkout')
	nnoremap <silent><buffer><expr>gd unite#do_action('diff')
	nnoremap <silent><buffer><expr>gu unite#do_action('unstage')
endfunction

function! s:unite_hooks.giti_branch()
  nnoremap <silent><buffer><expr>d unite#do_action('delete')
  nnoremap <silent><buffer><expr>D unite#do_action('delete_force')
  nnoremap <silent><buffer><expr>rd unite#do_action('delete_remote')
  nnoremap <silent><buffer><expr>rD unite#do_action('delete_remote_force')
endfunction

function! s:unite_hooks.giti_branch_all()
  call self.giti_branch()
endfunction

if !exists('gUunite_source_menu_menus')
    let g:unite_source_menu_menus = {}
endif

let g:unite_source_menu_menus.git = {
    \ 'description' : '            gestionar repositorios git
        \                            ⌘ [espacio]g',
    \}
let g:unite_source_menu_menus.git.command_candidates = [
    \['▷ tig                                                        ⌘ ,gt',
        \'normal ,gt'],
    \['▷ git status       (Fugitive)                                ⌘ ,gs',
        \'Gstatus'],
    \['▷ git diff         (Fugitive)                                ⌘ ,gd',
        \'Gdiff'],
    \['▷ git commit       (Fugitive)                                ⌘ ,gc',
        \'Gcommit'],
    \['▷ git log          (Fugitive)                                ⌘ ,gl',
        \'exe "silent Glog | Unite -no-quit -direction=botright quickfix"'],
    \['▷ git blame        (Fugitive)                                ⌘ ,gb',
        \'Gblame'],
    \['▷ git stage        (Fugitive)                                ⌘ ,gw',
        \'Gwrite'],
    \['▷ git checkout     (Fugitive)                                ⌘ ,go',
        \'Gread'],
    \['▷ git rm           (Fugitive)                                ⌘ ,gr',
        \'Gremove'],
    \['▷ git mv           (Fugitive)                                ⌘ ,gm',
        \'exe "Gmove " input("destino: ")'],
    \['▷ git push         (Fugitive, salida por buffer)             ⌘ ,gp',
        \'Git! push'],
    \['▷ git pull         (Fugitive, salida por buffer)             ⌘ ,gP',
        \'Git! pull'],
    \['▷ git prompt       (Fugitive, salida por buffer)             ⌘ ,gi',
        \'exe "Git! " input("comando git: ")'],
    \['▷ git cd           (Fugitive)',
        \'Gcd'],
    \]


if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroups'
    let g:unite_source_grep_recursive_opt = ''
endif
" }}}

" vimfiler{{{
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0

let g:vimfiler_tree_leaf_icon = ''
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = "*"
"}}}

" lightline{{{
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
      \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \   'ctrlpmark': 'CtrlPMark',
      \ },
      \ 'component_expand': {
      \   'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \   'syntastic': 'error',
      \ },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

function! LightLineModified()
    return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightLineReadonly()
    return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightLineFilename()
    let fname = expand('%:t')
    return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFugitive()
    try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
            let mark = ''  " edit here for cool mark
            let _ = fugitive#head()
            return strlen(_) ? mark._ : ''
        endif
    catch
    endtry
    return ''
endfunction

function! LightLineFileformat()
    return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
    return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction


function! LightLineMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'CtrlPStatusFunc_1',
  \ 'prog': 'CtrlPStatusFunc_2',
  \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str)
  return lightline#statusline(0)
endfunction

let g:tagbar_status_func = 'TagbarStatusFunc'

function! TagbarStatusFunc(current, sort, fname, ...) abort
    let g:lightline.fname = a:fname
  return lightline#statusline(0)
endfunction

let g:unite_force_overwrite_statusline = 0
let g:vimfiler_force_overwrite_statusline = 0
let g:vimshell_force_overwrite_statusline = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
"}}}

" Quickrun{{{
augroup quickrun
  autocmd!
  autocmd FileType quickrun AnsiEsc
augroup END

let g:quickrun_config = {
      \   '_' : {
      \     'runner' : 'vimproc',
      \     'outputter/buffer/split' : ':botright',
      \     'outputter/buffer/close_on_empty' : 1
      \   },
      \   'ruby.rspec': {
      \     'command': 'rspec',
      \     'cmdopt': '-c -fd --tty'
      \   },
      \   'ruby.rspec_line': {
      \     'command': 'rspec',
      \     'exec': "%c %s:%{line('.')} %o",
      \     'cmdopt': '-c -fd --tty'
      \   },
      \   'bundle.rspec': {
      \     'command': 'rspec',
      \     'exec': "bundle exec %c %s %o",
      \     'cmdopt': '-c -fd --tty'
      \   },
      \   'bundle.rspec_line': {
      \     'command': 'rspec',
      \     'exec': "bundle exec %c %s:%{line('.')} %o",
      \     'cmdopt': '-c -fd --tty'
      \   }
      \ }

augroup QRunRspec
  autocmd!
  autocmd BufWinEnter,BufRead,BufNewFile *_spec.rb set filetype=ruby.rspec
augroup END

nnoremap <silent> <Leader>rl :<C-u>QuickRun ruby.rspec_line<CR>
nnoremap <silent> <Leader>bl :<C-u>QuickRun bundle.rspec_line<CR>

function! RSpecSyntax()
  hi def link rubyRspecTestMethod             Function
  syn keyword rubyRspecTestMethod describe context it its specify shared_examples_for it_should_behave_like before after around subject fixtures controller_name helper_name
  syn match rubyRspecTestMethod '\<let\>!\='
  syn keyword rubyRspecTestMethod violated pending expect double mock mock_model stub_model
  syn match rubyRspecTestMethod '\.\@<!\<stub\>!\@!'
endfunction

autocmd Filetype ruby.rspec call RSpecSyntax()
"}}}

" Syntastic{{{
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
"}}}

" Neocomplete{{{
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 4
let g:neocomplete#enable_ignore_case = 1
let g:neocomplete#skip_auto_completion_time = '0.2'
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

"let g:neocomplete#sources#rsense#home_directory = '/usr/local/bin/rsense'

inoremap <expr><TAB> pumvisible() ? "\<C-n>" . neocomplete#close_popup() : "<TAB>"
"}}}

colorscheme hybrid

" vim: foldmethod=marker:
