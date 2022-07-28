" vim-plug =================================================================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
  " Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'sheerun/vim-polyglot'

  Plug 'rmagatti/auto-session'
  Plug 'b3nj5m1n/kommentary'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'kazhala/close-buffers.nvim'

  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'

  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'
call plug#end()

" theme ====================================================================
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
colorscheme pablo

autocmd vimenter * hi clear SignColumn
autocmd vimenter * hi clear TabLineFill
autocmd vimenter * hi clear TabLine
autocmd vimenter * hi clear VertSplit
autocmd vimenter * hi clear StatusLineNC

autocmd vimenter * hi clear TabLineSel
autocmd vimenter * hi clear StatusLine

autocmd vimenter * hi Visual        ctermbg=23
autocmd vimenter * hi TabLineSel    ctermfg=Yellow
autocmd vimenter * hi TabLine       ctermfg=DarkGray
autocmd vimenter * hi StatusLine    ctermfg=Yellow
autocmd vimenter * hi StatusLineNC  ctermfg=DarkGray
autocmd vimenter * hi Pmenu         ctermfg=LightGray ctermbg=Magenta
autocmd vimenter * hi PmenuSel      ctermfg=LightGray ctermbg=Black
autocmd vimenter * hi PmenuThumb    ctermfg=Black     ctermbg=Black

" built-in options =========================================================
set exrc
set nocompatible
set autoindent
set smartindent
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set list
set autoread
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
set foldmethod=indent
set nofoldenable

filetype plugin on
filetype indent off

" hotkeys ==================================================================
nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

nmap <leader>p "0p
vmap <leader>p "0p
nmap <leader>P "0P
vmap <leader>P "0P

nnoremap <leader>ee :Explore<CR>
nnoremap <leader>es :Hexplore<CR>
nnoremap <leader>ev :Vexplore<CR>
nnoremap <leader>et :Texplore<CR>

" lua config ===============================================================
lua require('init')
lua require('debugger')

" plug colors ==============================================================
autocmd vimenter * hi GitSignsAdd     guibg=NONE
autocmd vimenter * hi GitSignsChange  guibg=NONE
autocmd vimenter * hi GitSignsDelete  guibg=NONE
