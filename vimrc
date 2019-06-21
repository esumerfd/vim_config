"########################
" Local changes to vimrc
"########################
"########################
" How to debug:
" :profile start profile.log
" :profile func *
" :profile file *
" ---- At this point do slow actions
" :profile pause
" :noautocmd qall!
"
" OR
"
" vim --startuptime timeCost.txt timeCost.txt
"########################

call pathogen#helptags()

" Ruby syntax slow
" http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
"set re=1

" Window management
map <silent> <C-w>t <Esc>:tabe<CR>

" Clipboard
set clipboard+=unnamed

" Make CR clear the last search highlighting
nnoremap <CR> :noh<CR><CR>
nnoremap <F1> :noh<CR><CR>

" Disable swap files
:set noswapfile 

" Ignore case unless there is an Upper in the search string
set ignorecase
set smartcase

" Tags and TList setup
"let tlist_ant_settings = 'ant;p:project;t:target'
"let tlist_groovy_settings = 'groovy;p:package;c:class;i:interface;f:function;v:variables'

" Open word under cursor in new tab ApiDecoration
" Open file in current window
nnoremap <silent> ,oo :exec("tag ".expand("<cword>"))<CR>
" Open file in new tab
nnoremap <silent> ,o\ :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
" Open file above
nnoremap <silent> ,o} :split<CR>:exec("tag ".expand("<cword>"))<CR>
" Open file on left
nnoremap <silent> ,o] :vsplit<CR>:exec("tag ".expand("<cword>"))<CR>
" open test file on left
nnoremap <silent> ,ot :vsplit<CR>:exec("tag ".expand("<cword>")."Test")<CR>
" Open next file in NerdTree below
nnoremap <silent> ,on :split<CR><C-W>j:call FindInNERDTree()<CR>o<CR>

"map <silent> ,tt <Esc>:TlistToggle<CR>
nnoremap <silent> ,t     :tabe<CR>

nnoremap <silent> ,< 20<C-W><
nnoremap <silent> ,> 20<C-W>>

" Enter the double curlys for pickle"
nnoremap <silent> ,{ i{{  }}<ESC>hhi

nnoremap <silent> ,d yw:vsplit ../stackdb/db/ctdb/baseline_10.0.120/create_schema.sql<CR>/<c-r>"<CR>

command! -nargs=1 EditFile :e `find . -type f -iname <args>`

let mapleader=','
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif

"map <silent> 'ctf <Esc>:%s/@Test/\/\/@Test/<CR>
"map <silent> 'ctn <Esc>:%s/\/\/@Test/@Test/<CR>

let g:yankring_replace_n_pkey = '<C-P>'
let g:yankring_replace_n_nkey = '<C-n>'
nnoremap <silent> ,yr :YRGetElem<CR>
nnoremap <silent> ,ys :YRSearch<CR>

" Version Control
let VCSCommandSVNDiffExt = "vimdiff"
nnoremap <silent> ,vs     :VCSStatus<CR>
nnoremap <silent> ,vd     :VCSDiff<CR>

" Do not termimate files with new lines"
set noeol

" Custom Fie Types"
au BufRead,BufNewFile *.repo set filetype=dosini

" Ctrl-P
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git$\|\.hg$\|\.svn$\|\.yardoc$\|gen$|_build$',
  \ 'file': '\.dll$|\.exe$\|\.so$\|\.dat$'
  \ }

let g:ctrlp_map = ',p'
let g:ctrlp_cmd = 'CtrlP'

" 'c' - the directory of the current file.
" 'a' - the directory of the current file, unless it is a subdirectory of the cwd
" 'r' - the nearest ancestor of the current file that contains one of these directories or files: .git .hg .svn .bzr _darcs
" 'w' - modifier to "r": start search from the cwd instead of the current file's directory
" "0 or '' (empty string) - disable this feature.
let g:ctrlp_working_path_mode = 'ra'"

"nnoremap <silent> ,p     :CtrlP<CR>

" Fuzzy Finder
"
" let g:fuf_modesDisable = []
" let g:fuf_mrufile_maxItem = 1000
" let g:fuf_mrucmd_maxItem = 400
"let g:fuf_mrufile_exclude = '\v\~$|.*\.class$|.*/gen/.*$|.*\.(bak|sw[po])$|^(\/\/|\\\\|\/mnt\/)'
"let g:fuf_file_exclude = '\v\~$|\.(class|o|exe|dll|bak|orig|swp)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
"let g:fuf_dir_exclude = '^gen'
"let g:max_menu_width = 100

"nnoremap <silent> ,fb     :FufBuffer<CR>
"nnoremap <silent> ,fc     :FufCoverageFile<CR>
"nnoremap <silent> ,fF     :FufFile<CR>
"nnoremap <silent> ,ff     :FufFileWithCurrentBufferDir<CR>
"nnoremap <silent> ,fd     :FufDir<CR>
" nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
" nnoremap <silent> <C-f><C-d> :FufDirWithCurrentBufferDir<CR>
" nnoremap <silent> <C-f>d     :FufDirWithFullCwd<CR>
" nnoremap <silent> <C-j>      :FufMruFile<CR>
" nnoremap <silent> <C-k>      :FufMruCmd<CR>
" nnoremap <silent> <C-b>      :FufBookmarkDir<CR>
" nnoremap <silent> <C-f><C-t> :FufTag<CR>
" nnoremap <silent> <C-f>t     :FufTag!<CR>
" noremap  <silent> g]         :FufTagWithCursorWord!<CR>
" nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>
" nnoremap <silent> <C-f><C-j> :FufJumpList<CR>
" nnoremap <silent> <C-f><C-g> :FufChangeList<CR>
" nnoremap <silent> <C-f><C-q> :FufQuickfix<CR>
" nnoremap <silent> <C-f><C-l> :FufLine<CR>
" nnoremap <silent> <C-f><C-h> :FufHelp<CR>
" nnoremap <silent> <C-f><C-b> :FufAddBookmark<CR>
" vnoremap <silent> <C-f><C-b> :FufAddBookmarkAsSelectedText<CR>
" nnoremap <silent> <C-f><C-e> :FufEditInfo<CR>
" nnoremap <silent> <C-f><C-r> :FufRenewCache<CR>

" Toggle autoindex on paste mode
set pastetoggle=<F2>

" Simplify indentation in YML files by stopping auto indent.
filetype plugin indent on
autocmd FileType yaml setl indentkeys-=<:->
autocmd FileType cs setlocal shiftwidth=4 tabstop=4

" Improve paragraphing movement by ignoring blanks on the lines.
function! ParagraphMove(delta, visual, count)
  normal m'
  normal |
  if a:visual
    normal gv
  endif

  if a:count == 0
    let limit = 1
  else
    let limit = a:count
  endif

  let i = 0
  while i < limit
    if a:delta > 0
      " first whitespace-only line following a non-whitespace character           
      let pos1 = search("\\S", "W")
      let pos2 = search("^\\s*$", "W")
      if pos1 == 0 || pos2 == 0
        let pos = search("\\%$", "W")
      endif
    elseif a:delta < 0
      " first whitespace-only line preceding a non-whitespace character           
      let pos1 = search("\\S", "bW")
      let pos2 = search("^\\s*$", "bW")
      if pos1 == 0 || pos2 == 0
        let pos = search("\\%^", "bW")
      endif
    endif
    let i += 1
  endwhile
  normal |
endfunction

nnoremap <silent> } :<C-U>call ParagraphMove( 1, 0, v:count)<CR>
onoremap <silent> } :<C-U>call ParagraphMove( 1, 0, v:count)<CR>
vnoremap <silent> } :<C-U>call ParagraphMove( 1, 1, v:count)<CR>
nnoremap <silent> { :<C-U>call ParagraphMove(-1, 0, v:count)<CR>
onoremap <silent> { :<C-U>call ParagraphMove(-1, 0, v:count)<CR>
vnoremap <silent> { :<C-U>call ParagraphMove(-1, 1, v:count)<CR>

function! Vifm()
  silent !clear
  execute "!vifm " . fnamemodify(bufname("%"), ':p:h')
endfunction

nnoremap ,v :call Vifm()<CR>"

"########################
" Original Vimrc file.
"########################

"necessary on some Linux distros for pathogen to properly load bundles
filetype off

"load pathogen managed plugins
call pathogen#runtime_append_all_bundles()

"Use Vim settings, rather then Vi settings (much better!).
"This must be first, because it changes other options as a side effect.
set nocompatible

"allow backspacing over everything in insert mode
set backspace=indent,eol,start

"store lots of :cmdline history
set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

set number      "add line numbers
set showbreak=...
set wrap linebreak nolist

"mapping for command key to map navigation thru display lines instead of just numbered lines
vmap <D-j> gj
vmap <D-k> gk
vmap <D-4> g$
vmap <D-6> g^
vmap <D-0> g^
nmap <D-j> gj
nmap <D-k> gk
nmap <D-4> g$
nmap <D-6> g^
nmap <D-0> g^

"add some line space for easy reading
set linespace=4

"disable visual bell
set visualbell t_vb=

"try to make possible to navigate within lines of wrapped lines
nmap <Down> gj
nmap <Up> gk
set fo=l

"statusline setup
set statusline=%f       "tail of the filename

"Git
"set statusline+=[%{GitBranch()}]

"RVM
"set statusline+=%{exists('g:loaded_rvm')?rvm#statusline():''}

" Stop showing @ signs on the left, just display the damn text.
set display+=lastline

"display a warning if fileformat isnt unix
"set statusline+=%#warningmsg#
"set statusline+=%{&ff!='unix'?'['.&ff.']':''}
"set statusline+=%*

"Display a warning if file encoding isnt utf-8
"set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
"set statusline+=%*

"set statusline+=%h      "help file flag
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
"set statusline+=%#error#
"set statusline+=%{StatuslineTabWarning()}
"set statusline+=%*
"
"set statusline+=%{StatuslineTrailingSpaceWarning()}
"
"set statusline+=%{StatuslineLongLineWarning()}
"
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"display a warning if &paste is set
"set statusline+=%#error#
"set statusline+=%{&paste?'[paste]':''}
"set statusline+=%*

set statusline+=%=      "left/right separator

"set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight

set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
"set statusline+=\ %P    "percent through file
"
set laststatus=2

"turn off needless toolbar on gvim/mvim
set guioptions-=T

"recalculate the trailing whitespace warning when idle, and after saving
"autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction


"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let tabs = search('^\t', 'nw') != 0
        let spaces = search('^ ', 'nw') != 0

        if tabs && spaces
            let b:statusline_tab_warning =  '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        else
            let b:statusline_tab_warning = ''
        endif
    endif
    return b:statusline_tab_warning
endfunction

"recalculate the long line warning when idle and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

"return a warning for "long lines" where "long" is either &textwidth or 80 (if
"no &textwidth is set)
"
"return '' if no long lines
"return '[#x,my,$z] if long lines are found, were x is the number of long
"lines, y is the median length of the long lines and z is the length of the
"longest line
function! StatuslineLongLineWarning()
    if !exists("b:statusline_long_line_warning")
        let long_line_lens = s:LongLines()

        if len(long_line_lens) > 0
            let b:statusline_long_line_warning = "[" .
                        \ '#' . len(long_line_lens) . "," .
                        \ 'm' . s:Median(long_line_lens) . "," .
                        \ '$' . max(long_line_lens) . "]"
        else
            let b:statusline_long_line_warning = ""
        endif
    endif
    return b:statusline_long_line_warning
endfunction

"return a list containing the lengths of the long lines in this buffer
function! s:LongLines()
    let threshold = (&tw ? &tw : 80)
    let spaces = repeat(" ", &ts)

    let long_line_lens = []

    let i = 1
    while i <= line("$")
        let len = strlen(substitute(getline(i), '\t', spaces, 'g'))
        if len > threshold
            call add(long_line_lens, len)
        endif
        let i += 1
    endwhile

    return long_line_lens
endfunction

"find the median of the given array of numbers
function! s:Median(nums)
    let nums = sort(a:nums)
    let l = len(nums)

    if l % 2 == 1
        let i = (l-1) / 2
        return nums[i]
    else
        return (nums[l/2] + nums[(l/2)-1]) / 2
    endif
endfunction

"indent settings
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

" Ignore folders in ctrl-p
set wildignore+=*/gen/*,*/tmp/*,*.so,*.swp,*.zip,*/_build/*

"display tabs and trailing spaces
"set list
"set listchars=tab:\ \ ,extends:>,precedes:<
" disabling list because it interferes with soft wrap

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

" PeepOpen uses <Leader>p as well so you will need to redefine it so something
" else in your ~/.vimrc file, such as:
" nmap <silent> <Leader>q <Plug>PeepOpen

silent! nmap <silent> <Leader>p :NERDTreeToggle<CR>
nnoremap <silent> <C-f> :call FindInNERDTree()<CR> 

"vifm"
"make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>
inoremap <C-L> <C-O>:nohls<CR>

"map to bufexplorer
nnoremap <leader>be :BufExplorer<cr>

"map Q to something useful
noremap Q gq

"make Y consistent with C and D
nnoremap Y y$

"bindings for ragtag
inoremap <M-o>       <Esc>o
inoremap <C-j>       <Down>
let g:ragtag_global_maps = 1

"mark syntax errors with :signs
let g:syntastic_enable_signs=1

"key mapping for vimgrep result navigation
map <A-o> :copen<CR>
map <A-q> :cclose<CR>
map <A-j> :cnext<CR>
map <A-k> :cprevious<CR>

"snipmate setup
try
  source ~/.vim/snippets/support_functions.vim
catch
  source ~/vimfiles/snippets/support_functions.vim
endtry
"autocmd vimenter * call s:SetupSnippets()
"function! s:SetupSnippets()
    "call ExtractSnips("~/.vim/snippets/html", "eruby")
    "call ExtractSnips("~/.vim/snippets/html", "xhtml")
    "call ExtractSnips("~/.vim/snippets/html", "php")
"endfunction

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>


"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal! g`\""
            normal! zz
        endif
    end
endfunction

"define :HighlightLongLines command to highlight the offending parts of
"lines that are longer than the specified length (defaulting to 80)
command! -nargs=? HighlightLongLines call s:HighlightLongLines('<args>')
function! s:HighlightLongLines(width)
    let targetWidth = a:width != '' ? a:width : 79
    if targetWidth > 0
        exec 'match Todo /\%>' . (targetWidth) . 'v/'
    else
        echomsg "Usage: HighlightLongLines [natural number]"
    endif
endfunction

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

let ScreenShot = {'Icon':0, 'Credits':0, 'force_background':'#FFFFFF'} 

let g:fuf_file_exclude = '^target|^gen|\v\~$|\.o$|\.exe$|\.bak$|\.swp|\.class$|\.beam$'

map <C-w><C-[> :tabmove -1<CR>
map <C-w><C-]> :tabmove +1<CR>

