"===========================================================================
" bundle
"===========================================================================

set nocompatible 
filetype off

call vundle#rc()
set rtp+=~/.vim/bundle/vundle/
filetype plugin indent on

Bundle 'xoria256.vim'
Bundle 'colorer-color-scheme'
Bundle 'bufexplorer.zip'
Bundle 'The-NERD-tree'

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
"filetype on
"filetype plugin on
"filetype indent on

set autoindent
set smartindent
set shiftwidth=3
set softtabstop=3
set tabstop=3

set autoread
set autochdir
set completeopt=longest,menuone
set browsedir=buffer
set wildmenu
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

set hidden
set sessionoptions=curdir,buffers,tabpages

set novisualbell
set t_vb=   

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set laststatus=2

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

highlight PMenu ctermbg=238 gui=bold
highlight PMenuSel ctermbg=248 ctermfg=238 gui=bold

"===========================================================================
"Hex mode
"===========================================================================

command -bar Hexmode call ToggleHex()
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

"===========================================================================
" PHP options
"===========================================================================

"set dictionary=~/.vim/dic/php
"set makeprg=php\ -l\ %
"set errorformat=%m\ in\ %f\ on\ line\ %l

"let php_folding = 1
"let php_noShortTags = 1
"let php_sql_query=1
"let php_htmlInStrings=1 
"let php_baselib = 1

"===========================================================================
" python options
"===========================================================================

let python_highlight_all = 1

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

"===========================================================================
" Completion
"===========================================================================

set ofu=syntaxcomplete#Complete

function InsertTabWrapper()
     let col = col('.') - 1
     if !col || getline('.')[col - 1] !~ '\k'
         return "\<tab>"
     else
         return "\<c-p>"
     endif
endfunction
imap <tab> <c-r>=InsertTabWrapper()<cr>

set complete=""
set complete+=.
set complete+=k
set complete+=b
set complete+=t

imap <C-F> <C-X><C-O>

"===========================================================================
" Other hotkeys
"===========================================================================

nmap <Space> <PageDown>

nmap <F1> <esc>:BufExplorer<cr>
vmap <F1> <esc>:BufExplorer<cr>
imap <F1> <esc>:BufExplorer<cr>

nmap <F3> :bp<cr>
vmap <F3> <esc>:bp<cr>i
imap <F3> <esc>:bp<cr>i

nmap <F4> :bn<cr>
vmap <F4> <esc>:bn<cr>i
imap <F4> <esc>:bn<cr>i

nmap <F8> :bd<cr>
vmap <F8> <esc>:bd<cr>
imap <F8> <esc>:bd<cr>

noremap <F5> :! ./% 

nmap <F2>  <esc>:NERDTreeToggle<CR>
vmap <F2>  <esc>:NERDTreeToggle<CR>
imap <F2>  <esc>:NERDTreeToggle<CR>
