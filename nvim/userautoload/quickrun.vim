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
	  \	  'cpp' : {
	  \     'cmdopt': '--std=c++11'
	  \   }
	  \ }
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
