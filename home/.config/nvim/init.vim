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

	" lsp
	Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

"===========================================================================
" theme
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
" options
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
" sessions
"===========================================================================
let g:session_directory='~/.config/nvim/sessions'

"===========================================================================
" aliases
"===========================================================================

"===========================================================================
" hotkeys
"===========================================================================
nnoremap <A-Left>	:tabprevious<CR>
nnoremap <A-Right>	:tabnext<CR>

nnoremap <Esc>[1;3C	:tabnext<CR>
nnoremap <Esc>[1;3D	:tabprevious<CR>

nnoremap <leader>tt :tabnew<CR>

"===========================================================================
" syntax highlighting
"===========================================================================
syntax enable
autocmd BufRead,BufNewFile *.log set syntax=log

let g:session_autoload = 'no'
let g:session_autosave = 'yes'

"===========================================================================
" buffer explorer
"===========================================================================
nmap <F2> <esc>:BufExplorer<cr>
vmap <F2> <esc>:BufExplorer<cr>
imap <F2> <esc>:BufExplorer<cr>

"===========================================================================
" file navigator
"===========================================================================
let NERDTreeQuitOnOpen=1

nmap <F1>  <esc>:NERDTreeToggle<CR>
vmap <F1>  <esc>:NERDTreeToggle<CR>
imap <F1>  <esc>:NERDTreeToggle<CR>

"===========================================================================
" commenter
"===========================================================================
let g:NERDCommentEmptyLines=1
let g:NERDDefaultAlign = 'left'

nmap <C-_>	<Plug>NERDCommenterToggle<CR>
vmap <C-_>	<Plug>NERDCommenterToggle<CR>
imap <C-_>	<esc><Plug>NERDCommenterToggle<CR>

"if match($TERM, "linux")!=-1
"    nmap <BS>	<Plug>NERDCommenterToggle<CR>
"    vmap <BS>	<Plug>NERDCommenterToggle<CR>
"    imap <BS>	<esc><Plug>NERDCommenterToggle<CR>
"endif

"===========================================================================
" debbuger
"===========================================================================

"===========================================================================
" coc.vim
"===========================================================================
nmap <silent> <leader>ld <Plug>(coc-definition)
nmap <silent> <leader>ly <Plug>(coc-type-definition)
nmap <silent> <leader>li <Plug>(coc-implementation)
nmap <silent> <leader>lr <Plug>(coc-references)

nmap <silent> <leader>l[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>l] <Plug>(coc-diagnostic-next)

nmap <leader>lr	<Plug>(coc-rename)

xmap <leader>lf	<Plug>(coc-format-selected)
nmap <leader>lf	<Plug>(coc-format-selected)

xmap <leader>la	<Plug>(coc-codeaction-selected)
nmap <leader>la	<Plug>(coc-codeaction-selected)

"===========================================================================
" completion
"===========================================================================
set completeopt=menu,menuone,preview,noselect,noinsert

inoremap <expr> <Tab>	pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab>	pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>	pumvisible() ? "\<C-y>" : "\<cr>"

