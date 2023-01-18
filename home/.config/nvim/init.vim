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
colorscheme desert
if has('termguicolors')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  set termguicolors

  autocmd vimenter * hi normal guibg=000000
  autocmd vimenter * hi clear NonText
  autocmd vimenter * hi clear SignColumn
  autocmd vimenter * hi TabLineSel    guibg=darkcyan  guifg=white
  autocmd vimenter * hi TabLineFill   guibg=black
  autocmd vimenter * hi TabLine       guibg=black     guifg=lightgray
  autocmd vimenter * hi StatusLine    guibg=darkcyan  guifg=white
  autocmd vimenter * hi StatusLineNC  guibg=black     guifg=lightgray
  autocmd VimEnter * hi VertSplit     guibg=NONE      cterm=NONE
endif

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

nnoremap <leader>ee :Explore<CR>
nnoremap <leader>es :Hexplore<CR>
nnoremap <leader>ev :Vexplore<CR>
nnoremap <leader>et :Texplore<CR>

" lua config ===============================================================
lua require('init')
" lua require('debugger')

" plug colors ==============================================================
autocmd vimenter * hi GitSignsAdd     guibg=NONE
autocmd vimenter * hi GitSignsChange  guibg=NONE
autocmd vimenter * hi GitSignsDelete  guibg=NONE
