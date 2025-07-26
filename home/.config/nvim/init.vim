" vim-plug =================================================================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  " Plug 'towolf/vim-helm'
  " Plug 'sheerun/vim-polyglot'

  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim'

  Plug 'rmagatti/auto-session'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'kazhala/close-buffers.nvim'

  Plug 'neovim/nvim-lspconfig'
  Plug 'rafamadriz/friendly-snippets'
  Plug 'saghen/blink.cmp', { 'tag': '*' }

  Plug 'mfussenegger/nvim-dap'
  Plug 'rcarriga/nvim-dap-ui'

  Plug 'dracula/vim'
call plug#end()

" theme ====================================================================
colorscheme dracula

if has('termguicolors')
   let $NVIM_TUI_ENABLE_TRUE_COLOR=1
   set termguicolors

   autocmd vimenter * hi Normal guibg=000000
   autocmd vimenter * hi EndOfBuffer guibg=000000

   "autocmd vimenter * hi MatchParen ctermfg=white ctermbg=white cterm=NONE gui=NONE guibg=white guifg=white
   "autocmd vimenter * hi MatchParen guibg=LightGreen guifg=black
   "autocmd vimenter * hi clear NonText

   autocmd vimenter * hi clear SignColumn
   autocmd vimenter * hi TabLineSel    guifg=white       guibg=darkgreen gui=NONE  cterm=NONE
   autocmd vimenter * hi TabLineFill                     guibg=black     gui=NONE  cterm=NONE
   autocmd vimenter * hi TabLine       guifg=lightgray   guibg=black     gui=NONE  cterm=NONE
   autocmd vimenter * hi StatusLine    guifg=white       guibg=darkgreen gui=NONE  cterm=NONE
   autocmd vimenter * hi StatusLineNC  guifg=lightgray   guibg=black     gui=NONE  cterm=NONE

   "autocmd vimenter * hi VertSplit                       guibg=NONE      gui=NONE  cterm=NONE
   "autocmd vimenter * hi Pmenu         guifg=fg          guibg=#303030   gui=NONE  cterm=NONE
   "autocmd vimenter * hi PmenuSbar     guifg=NONE        guibg=NONE      gui=NONE  cterm=NONE
   "autocmd vimenter * hi PmenuSel      guifg=#000000     guibg=#e5e5e5   gui=NONE  cterm=NONE
   "autocmd vimenter * hi PmenuThumb    guifg=NONE        guibg=#ffffff   gui=NONE  cterm=NONE
   "autocmd vimenter * hi Visual        guifg=#f0e68c     guibg=#6b8e24   gui=NONE  cterm=NONE
   "autocmd vimenter * hi VisualNOS     guifg=#f0e68c     guibg=#6dceeb   gui=none  cterm=none
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
set fileencodings=utf8,cp1251,cp866,koi8-r
set statusline=%<%F%m%r\ %=\ %h%w%q\ %l,%c%V\ %{&encoding}\ %P\ %y
set laststatus=2
set mousemodel=extend
set foldmethod=indent
set nofoldenable

filetype plugin on
filetype indent off

" hotkeys ==================================================================
nnoremap <leader>tt :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>

nnoremap <leader>ee :Explore<CR>
nnoremap <leader>es :Hexplore<CR>
nnoremap <leader>ev :Vexplore!<CR>
nnoremap <leader>et :Texplore<CR>

" disable primary-paste
map   <MiddleMouse> <Nop>
imap  <MiddleMouse> <Nop>

" disable help
nmap <F1> <nop>

" lua config ===============================================================
lua require('init')
" lua require('debugger')

" plug colors ==============================================================
autocmd vimenter * hi GitSignsAdd     guibg=NONE
autocmd vimenter * hi GitSignsChange  guibg=NONE
autocmd vimenter * hi GitSignsDelete  guibg=NONE
