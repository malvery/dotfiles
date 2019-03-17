"===========================================================================
" vim-plug
"===========================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
	" themes
	Plug 'morhetz/gruvbox'
	Plug 'joshdick/onedark.vim'
	
	" syntax highlighting
	Plug 'sheerun/vim-polyglot'
	Plug 'mtdl9/vim-log-highlighting'

	" buffers explorer
	Plug 'jlanzarotta/bufexplorer'

	" session
	Plug 'xolox/vim-misc'
	Plug 'xolox/vim-session'
	
	" file navigator
	Plug 'scrooloose/nerdtree'

	" comments
	Plug 'scrooloose/nerdcommenter'

	" file formatting
	Plug 'Chiel92/vim-autoformat'

	" git integration
	Plug 'Xuyuanp/nerdtree-git-plugin'
	Plug 'mhinz/vim-signify'
	Plug 'cohama/agit.vim'

	" LSP
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'

	" complete
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	Plug 'prabirshrestha/asyncomplete-file.vim'
	"Plug 'yami-beta/asyncomplete-omni.vim'
	
	" debugger
	Plug 'KangOl/vim-pudb'
	"Plug 'SkyLeach/pudb.vim'

call plug#end()

"===========================================================================
" Theme
"===========================================================================
if &t_Co == 256 || has("gui_running")
	set t_Co=256
	set background=dark
	let g:gruvbox_contrast_dark='hard'
	colorscheme gruvbox

else
	colorscheme default
endif

"===========================================================================
" VIM options
"===========================================================================
set nocompatible
set autoindent
set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2
set autoread
set autochdir
set nu
set showcmd

set hlsearch
set incsearch
set ignorecase

set nobackup
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf8,cp1251,cp866,koi8-r

set statusline=%<%F%m%r\ %=\ %h%w%q\ %l,%c%V\ %{&encoding}\ %P\ %y
set laststatus=2

"set ttymouse=xterm2
set mouse=a

"===========================================================================
" GUI options
"===========================================================================
if has("gui_running")
	set guioptions-=T
	set guifont=Hack\ 10
	set linespace=1
	set wildmenu
	set wcm=<Tab> 

	menu Encoding.utf-8 :e ++enc=utf8 <CR>
	menu Encoding.windows-1251 :e ++enc=cp1251<CR>
	menu Encoding.koi8-r :e ++enc=koi8-r<CR>
	menu Encoding.cp866 :e ++enc=cp866<CR>

	nnoremap yy yy"+yy
	vnoremap y ygv"+y
endif

"===========================================================================
" Functions
"===========================================================================

"===========================================================================
" Alias
"===========================================================================
"command JsonFormat %! python -m json.tool

"===========================================================================
" Hotkeys
"===========================================================================
nnoremap <C-A-n>			:tabnew<CR>
nnoremap <C-A-Left>		:tabprevious<CR>
nnoremap <C-A-Right>	:tabnext<CR>

"===========================================================================
" Syntax highlighting
"===========================================================================
syntax enable
autocmd BufRead,BufNewFile *.log set syntax=log

let g:session_autoload = 'no'
let g:session_autosave = 'yes'

"===========================================================================
" Buffer explorer
"===========================================================================
nmap <F1> <esc>:BufExplorer<cr>
vmap <F1> <esc>:BufExplorer<cr>
imap <F1> <esc>:BufExplorer<cr>

"===========================================================================
" File navigator
"===========================================================================
let NERDTreeQuitOnOpen=1

nmap <F2>  <esc>:NERDTreeToggle<CR>
vmap <F2>  <esc>:NERDTreeToggle<CR>
imap <F2>  <esc>:NERDTreeToggle<CR>

"===========================================================================
" Comments
"===========================================================================
filetype plugin on

let g:NERDCommentEmptyLines=1
let g:NERDDefaultAlign = 'left'

nmap <C-_>	<Plug>NERDCommenterToggle<CR>
vmap <C-_>	<Plug>NERDCommenterToggle<CR>
imap <C-_>	<esc><Plug>NERDCommenterToggle<CR>

"===========================================================================
" Completion
"===========================================================================
let g:asyncomplete_remove_duplicates = 1
"let g:asyncomplete_smart_completion = 1
"let g:asyncomplete_auto_popup = 1

inoremap <expr> <Tab>		pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>		pumvisible() ? "\<C-y>" : "\<cr>"

imap <c-space> <Plug>(asyncomplete_force_refresh)

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
  \ 'name': 'file',
  \ 'whitelist': ['*'],
  \ 'priority': 10,
  \ 'completor': function('asyncomplete#sources#file#completor')
  \ }))

"au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
"  \ 'name': 'omni',
"  \ 'whitelist': ['*'],
"  \ 'blacklist': ['c', 'cpp', 'html'],
"  \ 'priority': 0,
"  \ 'completor': function('asyncomplete#sources#omni#completor')
"  \  }))

"===========================================================================
" LSP Sources
"===========================================================================
"let g:lsp_log_verbose = 1
"let g:lsp_log_file = expand('~/vim-lsp.log')
"let g:asyncomplete_log_file = expand('~/asyncomplete.log')

if executable('pyls')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'pyls',
		\ 'cmd': {server_info->['pyls']},
		\ 'whitelist': ['python'],
		\ })
endif

if executable('lua-lsp')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'lua-lsp',
		 \ 'cmd': {server_info->[&shell, &shellcmdflag, 'lua-lsp']},
		 \ 'whitelist': ['lua'],
		 \ })
endif

if executable('bash-language-server')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'bash-language-server',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'bash-language-server start']},
		\ 'whitelist': ['sh'],
		\ })
endif

if executable('vscode-json-languageserver')
	au User lsp_setup call lsp#register_server({
		\ 'name': 'vscode-json-languageserver',
		\ 'cmd': {server_info->[&shell, &shellcmdflag, 'vscode-json-languageserver --stdio']},
		\ 'whitelist': ['json'],
		\ })
endif

"===========================================================================
" LSP Hotkeys
"===========================================================================
:nnoremap <leader>lr :LspRename<CR>
:nnoremap <leader>ln :LspReferences<CR>
:nnoremap <leader>ld :LspDefinition<CR>
:nnoremap <leader>lk :LspHover<CR>

:nnoremap <leader>li :LspDocumentFormat<CR>
:vnoremap <leader>li :LspDocumentRangeFormat<CR>

:nnoremap <leader>lo :LspDocumentDiagnostics<CR>
:nnoremap <leader>ls :LspDocumentSymbol<CR>

:nnoremap <leader>lw :LspNextError<CR>
:nnoremap <leader>lW :LspPreviousError<CR>

"===========================================================================
" Debbuger Hotkeys
"===========================================================================
nnoremap <leader>db :TogglePudbBreakPoint<CR>
inoremap <leader>db <ESC>:TogglePudbBreakPoint<CR>a

