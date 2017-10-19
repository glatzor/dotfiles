" Enable pathogen bundles
call pathogen#infect()
call pathogen#helptags()

" always set autoindenting on
set autoindent
" Don't wrap lines by default 
set textwidth=0
" Show (partial) command in status line.
set showcmd

" Keep a backup file
set backupcopy=no
" Automatically save before commands like :next and :make
set autowrite

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Do case insensitive matching
set ignorecase
" When searching try to be smart about cases
set smartcase
" Incremental search
set incsearch
" Highlight search results
set hlsearch
" Disable highlighting with RETURN and clean the command line afterwards
nnoremap <silent> <CR> :noh<CR><CR>

set modelines=5

" No annoying sound on errors
set noerrorbells
set novisualbell
set timeoutlen=500

set hidden
set wildmenu
set guioptions-=T

set t_Co=256

"Use mouse in normal, visual and command but not input mode
set mouse=nvc

" Enable syntax highlightening
syntax on
" Show matching brackets.
set showmatch

" Show each buffer in a separate tab
set switchbuf=newtab

" Theming
set background=dark
colorscheme solarized
" Toggle between dark and light theme by pressing F5
call togglebg#map("")
 
" With a map leader it's possible to do extra key combinations
let mapleader = " "
let g:mapleader = " "

" Fast saving
nmap <leader>w :w!<cr>

" Breaking lines with \[enter] without having to go to insert mode (myself).
nmap <leader><cr> i<cr><Esc>

" Move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Starting from vim 7.3 undo can be persisted across sessions
" http://www.reddit.com/r/vim/comments/kz84u/what_are_some_simple_yet_mindblowing_tweaks_to/c2onmqe
if has("persistent_undo")
	set undodir=~/.vim/undodir
	set undofile
endif

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif
" Remember info about open buffers on close
set viminfo^=%

" Always show the status line
set laststatus=2
" Format the status line, include GIT branch
set statusline=%<%f\ %{fugitive#statusline()}\ %h%m%r%=%-14.(%l,%c%V%)\ %P

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'

function! ToggleErrors()
	if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
		" No location/quickfix list shown, open syntastic error location panel
		Errors
	else
		lclose
	endif
endfunction
" toggle the Error Panel with Ctrl-e you can use the following mapping
nnoremap <silent> <C-e> :<C-u>call ToggleErrors()<CR>

" Pandoc
autocmd BufNewFile,BufRead *.markdown,*.mkd,*.md set filetype=pandoc
let g:pandoc#syntax#conceal#use=0
" pandoc Markdown+LaTeX
function s:MDSettings()
    inoremap <buffer> <Leader>n \note[item]{}<Esc>i
    noremap <buffer> <Leader>b :! pandoc -t beamer % -o %<.pdf<CR><CR>
    noremap <buffer> <Leader>l :! pandoc -t latex % -o %<.pdf<CR>
    noremap <buffer> <Leader>v :! evince %<.pdf 2>&1 >/dev/null &<CR><CR>

    " adjust syntax highlighting for LaTeX parts
    "   inline formulas:
    syntax region Statement oneline matchgroup=Delimiter start="\$" end="\$"
    "   environments:
    syntax region Statement matchgroup=Delimiter start="\\begin{.*}" end="\\end{.*}" contains=Statement
    "   commands:
    syntax region Statement matchgroup=Delimiter start="{" end="}" contains=Statement
endfunction
autocmd FileType pandoc :call <SID>MDSettings()

" tagbar
nnoremap <silent> <F9> :TagbarToggle<CR>
let g:tagbar_autoclose=1
let g:tagbar_right=1
let g:tagbar_autofocus=1 
let g:tagbar_expand=1

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" root dir is current and nearest VCS root dir
let g:ctrlp_working_path_mode = 'ra'

" NERDTree
nnoremap <silent> <F8> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowBookmarks = 1

" airline
let g:ariline_theme="solarized"
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '»'
"let g:airline_left_sep = '▶'
let g:airline_left_sep = ''
let g:airline_right_sep = '«'
"let g:airline_right_sep = '◀'
let g:airline_right_sep = ''
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" EasyMotion colors
hi link EasyMotionTarget Question
hi link EasyMotionShade  Comment
hi link EasyMotionTarget2First Question
hi link EasyMotionTarget2Second MoreMsg
