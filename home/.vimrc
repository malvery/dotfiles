"===========================================================================
" bundle
"===========================================================================

set nocompatible 
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

filetype plugin indent on

Bundle 'xoria256.vim'
Bundle 'colorer-color-scheme'
Bundle 'bufexplorer.zip'
Bundle 'The-NERD-tree'
Bundle 'SuperTab'
Bundle 'ruby.vim'
Bundle 'The-NERD-Commenter'
Bundle 'xml.vim'

"===========================================================================
" theme
"===========================================================================

if &t_Co == 256 || has("gui_running")
	set t_Co=256
	colorscheme xoria256
else
	colorscheme colorer
endif

"===========================================================================
" options
"===========================================================================

syntax on

set autoindent
set smartindent
set shiftwidth=3
set softtabstop=3
set tabstop=3

set autoread
set autochdir
set nu
set showcmd

set hlsearch
set incsearch
set ignorecase

set nobackup
set noswapfile
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf8,cp1251,cp866,koi8-r

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set laststatus=2

highlight PMenu ctermbg=238 gui=bold
highlight PMenuSel ctermbg=248 ctermfg=238 gui=bold

"===========================================================================
" Completion
"===========================================================================


"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
"autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
"autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

"===========================================================================
" Hotkeys
"===========================================================================

nmap <C-o> <esc>:sh<cr>
vmap <C-o> <esc>:sh<cr>
imap <C-o> <esc>:sh<cr>

nmap <F1> <esc>:BufExplorer<cr>
vmap <F1> <esc>:BufExplorer<cr>
imap <F1> <esc>:BufExplorer<cr>

nmap <F12>  <esc>:NERDTreeToggle<CR>
vmap <F12>  <esc>:NERDTreeToggle<CR>
imap <F12>  <esc>:NERDTreeToggle<CR>

noremap <F9> :! ./% 
