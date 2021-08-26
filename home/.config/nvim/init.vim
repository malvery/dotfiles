" vim-plug =================================================================
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
	Plug 'morhetz/gruvbox'
	" Plug 'lifepillar/vim-solarized8'

	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'rmagatti/auto-session'

	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'

	Plug 'phaazon/hop.nvim'
	Plug 'b3nj5m1n/kommentary'
	Plug 'mhinz/vim-signify'

	Plug 'neovim/nvim-lspconfig'
	Plug 'hrsh7th/nvim-compe'

	Plug 'mfussenegger/nvim-dap'
	Plug 'rcarriga/nvim-dap-ui'
call plug#end()

" theme ====================================================================
if &t_Co == 256 || has("gui_running")
	" if has('termguicolors')
	" 	set termguicolors
	" endif
	
	" let g:solarized_termtrans = 1
	" colorscheme solarized8
	
	let g:gruvbox_transparent_bg = 1
	" let g:gruvbox_bold = 0
	let g:gruvbox_contrast_dark = "hard"
	colorscheme gruvbox
else
	colorscheme desert
endif

" built-in options =========================================================
set exrc
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

" hotkeys ==================================================================
nnoremap <A-Left>	:tabprevious<CR>
nnoremap <A-Right>	:tabnext<CR>
inoremap <A-Left>	<esc>:tabprevious<CR>
inoremap <A-Right>	<esc>:tabnext<CR>
nnoremap <Esc>[1;3C	:tabnext<CR>
nnoremap <Esc>[1;3D	:tabprevious<CR>
nnoremap <leader>tt :tabnew<CR>

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

inoremap <A-1> <esc>1gt
inoremap <A-2> <esc>2gt
inoremap <A-3> <esc>3gt
inoremap <A-4> <esc>4gt
inoremap <A-5> <esc>5gt
inoremap <A-6> <esc>6gt
inoremap <A-7> <esc>7gt
inoremap <A-8> <esc>8gt
inoremap <A-9> <esc>9gt

nmap <F1> <esc>:Telescope file_browser<CR>
vmap <F1> <esc>:Telescope file_browser<CR>
imap <F1> <esc>:Telescope file_browser<CR>

nmap <F2> <esc>:Telescope buffers<cr>
vmap <F2> <esc>:Telescope buffers<cr>
imap <F2> <esc>:Telescope buffers<cr>

nnoremap <leader>li	:Telescope lsp_workspace_diagnostics<CR>
nnoremap <leader>gs	:Telescope git_status<CR>
nnoremap <leader>gb	:Telescope git_branches<CR>

nnoremap <leader>ss :HopWord<CR>
nnoremap <leader>sc :HopChar2<CR>

" lua config ===============================================================
lua require('init')
lua require('debugger')
