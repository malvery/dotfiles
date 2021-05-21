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
	Plug 'prabirshrestha/vim-lsp'
	Plug 'mattn/vim-lsp-settings'

	" autocomplete
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'

	" debbuger
	Plug 'puremourning/vimspector'

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

inoremap <A-Left>	<esc>:tabprevious<CR>
inoremap <A-Right>	<esc>:tabnext<CR>

nnoremap <Esc>[1;3C	:tabnext<CR>
nnoremap <Esc>[1;3D	:tabprevious<CR>

nnoremap <leader>tt :tabnew<CR>

nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt

inoremap <A-1> <esc>1gt
inoremap <A-2> <esc>2gt
inoremap <A-3> <esc>3gt
inoremap <A-4> <esc>4gt
inoremap <A-5> <esc>5gt
inoremap <A-6> <esc>6gt
inoremap <A-7> <esc>7gt
inoremap <A-8> <esc>8gt
inoremap <A-9> <esc>9gt

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

let NERDTreeShowHidden=1

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
let g:vimspector_enable_mappings = 'VISUAL_STUDIO'
"packadd! vimspector

"===========================================================================
" vim-lsp
"===========================================================================
let g:lsp_diagnostics_highlights_enabled	= 0
let g:lsp_diagnostics_virtual_text_enabled	= 0

highlight link LspWarningText	GruvboxYellowSign
highlight link LspErrorText		GruvboxRedSign

highlight link LspWarningHighlight	GruvboxYellowSign
highlight link LspErrorHighlight	GruvboxRedSign

nmap <silent> <leader>lot :LspPeekTypeDefinition<CR>
nmap <silent> <leader>loi :LspPeekImplementation<CR>
nmap <silent> <leader>lor :LspReferences<CR>

nmap <silent> <leader>l[ :LspPreviousDiagnostic<CR>
nmap <silent> <leader>l] :LspNextDiagnostic<CR>

nmap <silent> <leader>ld :LspDefinition<CR>

nmap <leader>lr	:LspRename<CR>
nmap <leader>lh	:LspHover<CR>

xmap <leader>lf	:LspDocumentRangeFormat<CR>
nmap <leader>lf	:LspDocumentFormat<CR>

nmap <leader>la	:LspCodeAction<CR>
nmap <leader>li	:LspDocumentDiagnostics<CR>

"===========================================================================
" completion
"===========================================================================
set completeopt=menu,menuone,preview,noselect,noinsert
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

