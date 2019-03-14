"===========================================================================
" Vundle
"===========================================================================
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"===========================================================================
" Theme
"===========================================================================
Plugin 'sheerun/vim-polyglot'
Plugin 'morhetz/gruvbox'
Plugin 'joshdick/onedark.vim'

if &t_Co == 256 || has("gui_running")
	set t_Co=256
	set background=dark
	let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

else
	colorscheme default
endif

"===========================================================================
" options
"===========================================================================
syntax enable

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
"set noswapfile
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf8,cp1251,cp866,koi8-r

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set laststatus=2

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
" Completion
"===========================================================================


"===========================================================================
" Alias
"===========================================================================

"command JsonFormat %! python -m json.tool

"===========================================================================
" Hotkeys
"===========================================================================

"nnoremap <C-n>			:tabnew<CR>
"nnoremap <C-Left>		:tabprevious<CR>
"nnoremap <C-Right>	:tabnext<CR>

"===========================================================================
" Plugins
"===========================================================================

"===== Session
Bundle 'vim-misc'
Bundle 'vim-session'

let g:session_autoload = 'no'
let g:session_autosave = 'yes'

"===== Buffers explorer
Plugin 'jlanzarotta/bufexplorer'

nmap <F1> <esc>:BufExplorer<cr>
vmap <F1> <esc>:BufExplorer<cr>
imap <F1> <esc>:BufExplorer<cr>

"===== File navigator
Plugin 'scrooloose/nerdtree'

let NERDTreeQuitOnOpen=1

nmap <F12>  <esc>:NERDTreeToggle<CR>
vmap <F12>  <esc>:NERDTreeToggle<CR>
imap <F12>  <esc>:NERDTreeToggle<CR>

"===== Comments
Plugin 'scrooloose/nerdcommenter'
filetype plugin on

let g:NERDCommentEmptyLines=1
let g:NERDDefaultAlign = 'left'

nmap <C-_>	<Plug>NERDCommenterToggle<CR>
vmap <C-_>	<Plug>NERDCommenterToggle<CR>
imap <C-_>	<esc><Plug>NERDCommenterToggle<CR>

"===== File formatting
Plugin 'Chiel92/vim-autoformat'

"===== Linters

"===== Completions

"===== Python

"===== Git integration
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'

