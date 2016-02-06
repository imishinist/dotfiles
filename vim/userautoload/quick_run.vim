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

