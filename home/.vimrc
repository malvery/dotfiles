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
Bundle 'ruby.vim'
Bundle 'The-NERD-Commenter'
Bundle 'xml.vim'
Bundle 'snipMate'
Bundle 'AutoComplPop'

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
set noswapfile
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf8,cp1251,cp866,koi8-r

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set laststatus=2

highlight PMenu ctermbg=238 gui=bold
highlight PMenuSel ctermbg=248 ctermfg=238 gui=bold

"===========================================================================
" Functions
"===========================================================================

function! TabComplete()
  let line = getline('.')                         " current line

  let substr = strpart(line, -1, col('.')+1)      " from the start of the current
                                                  " line to one character right
                                                  " of the cursor
  let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
  if (strlen(substr)==0)                          " nothing to match on empty string
    return "\<tab>"
  endif
  let has_period = match(substr, '\.') != -1      " position of period, if any
  let has_slash = match(substr, '\/') != -1       " position of slash, if any
  if (!has_period && !has_slash)
		return "\<C-X>\<C-O>"                         " plugin matching
  elseif ( has_slash )
    return "\<C-X>\<C-F>"                         " file matching
  else
   	return "\<C-X>\<C-P>"                         " existing text matching
  endif
endfunction

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

inoremap <C-f> <c-r>=TabComplete()<CR>

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
