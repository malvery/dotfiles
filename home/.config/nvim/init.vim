"===========================================================================
" vim-plug
"===========================================================================

if has('nvim')
	if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
		silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif

else
	if empty(glob('~/.vim/autoload/plug.vim'))
		silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
			\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
		autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
endif


call plug#begin('~/.config/nvim/plugged')
	" theme
	Plug 'morhetz/gruvbox'

	" syntax highlighting
	Plug 'sheerun/vim-polyglot'
	Plug 'mtdl9/vim-log-highlighting'

	" buffers explorer
	Plug 'jlanzarotta/bufexplorer'

	" sessions
	Plug 'xolox/vim-misc'
	Plug 'xolox/vim-session'

	" file navigator
	Plug 'scrooloose/nerdtree'

	" commenter
	Plug 'scrooloose/nerdcommenter'

	" git integration
	Plug 'mhinz/vim-signify'

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
set shiftwidth=4
set softtabstop=4
set tabstop=4
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

set mouse=a

filetype plugin on
if &filetype==""
	setfiletype conf
endif

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
endif

nnoremap yy yy"+yy
vnoremap y ygv"+y

"===========================================================================
" Sessions
"===========================================================================
let g:session_directory='~/.config/nvim/sessions'

"===========================================================================
" Alias
"===========================================================================

"===========================================================================
" Hotkeys
"===========================================================================
nnoremap <A-Left>		:tabprevious<CR>
nnoremap <A-Right>	:tabnext<CR>

nnoremap <Esc>[1;3C	:tabnext<CR>
nnoremap <Esc>[1;3D	:tabprevious<CR>

nnoremap <leader>tt :tabnew<CR>

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
nmap <F2> <esc>:BufExplorer<cr>
vmap <F2> <esc>:BufExplorer<cr>
imap <F2> <esc>:BufExplorer<cr>

"===========================================================================
" File navigator
"===========================================================================
let NERDTreeQuitOnOpen=1

nmap <F1>  <esc>:NERDTreeToggle<CR>
vmap <F1>  <esc>:NERDTreeToggle<CR>
imap <F1>  <esc>:NERDTreeToggle<CR>

"===========================================================================
" Comments
"===========================================================================
let g:NERDCommentEmptyLines=1
let g:NERDDefaultAlign = 'left'

nmap <C-_>	<Plug>NERDCommenterToggle<CR>
vmap <C-_>	<Plug>NERDCommenterToggle<CR>
imap <C-_>	<esc><Plug>NERDCommenterToggle<CR>

"===========================================================================
" Debbuger Hotkeys
"===========================================================================

"===========================================================================
" Linter Fixing
"===========================================================================

"===========================================================================
" Completion
"===========================================================================
set completeopt=menu,menuone,preview,noselect,noinsert

inoremap <expr> <Tab>		pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>		pumvisible() ? "\<C-y>" : "\<cr>"

