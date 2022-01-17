" vim-plug =================================================================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'KeitaNakamura/neodark.vim'
  Plug 'towolf/vim-helm'

  Plug 'phaazon/hop.nvim'
  Plug 'rmagatti/auto-session'
  Plug 'b3nj5m1n/kommentary'
  Plug 'nvim-lua/plenary.nvim'
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
if &t_Co == 256 || has("gui_running")
  if has('termguicolors')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    set termguicolors
  endif

  " colorscheme rigel
  let g:neodark#background = '#171721'
  colorscheme neodark
else
  colorscheme desert
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
" set spell spelllang=en_us
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
if &filetype==""
  setfiletype conf
endif

" hotkeys ==================================================================
nnoremap <A-h>      :tabprevious<CR>
nnoremap <A-l>      :tabnext<CR>
nnoremap <A-S-h>    :tabm -1<CR>
nnoremap <A-S-l>    :tabm +1<CR>
nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

nmap <leader>p "0p
vmap <leader>p "0p
nmap <leader>P "0P
vmap <leader>P "0P

nnoremap <A-1> 1gt
nnoremap <A-2> 2gt
nnoremap <A-3> 3gt
nnoremap <A-4> 4gt
nnoremap <A-5> 5gt
nnoremap <A-6> 6gt
nnoremap <A-7> 7gt
nnoremap <A-8> 8gt
nnoremap <A-9> 9gt

nnoremap <leader>ss :HopWord<CR>
nnoremap <leader>sc :HopChar2<CR>

nnoremap <leader>ee :Explore<CR>
nnoremap <leader>es :Hexplore<CR>
nnoremap <leader>ev :Vexplore<CR>
nnoremap <leader>et :Texplore<CR>

" lua config ===============================================================
lua require('init')
lua require('debugger')
