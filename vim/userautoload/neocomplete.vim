
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

