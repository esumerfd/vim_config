" Standard VI settings
set clipboard+=unnamed
set noswapfile
set ignorecase
set smartcase

nnoremap <silent> ,t     :tabe<CR>

nnoremap <silent> ,< 20<C-W><
nnoremap <silent> ,> 20<C-W>>

" Pickle
nnoremap <silent> ,{ i{{  }}<ESC>hhi

" Open Project Files
nnoremap <silent> ,d yw:vsplit ../stackdb/db/ctdb/baseline_10.0.120/create_schema.sql<CR>/<c-r>"<CR>

" Custom commands
command! -nargs=1 File :e `find . -type f -iname <args>`
command! CopyPath let @+ = expand('%:p')

" Plugin: Sideways
nnoremap <silent> ,ah :SidewaysLeft<cr>
nnoremap <silent> ,al :SidewaysRight<cr>


