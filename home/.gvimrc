"colorscheme asmanian2 

" Change color scheme by day time
"let dayBegin = 9
"let dayScheme = "asmanian2"
"let nightBegin = 19
"let nightScheme = "rdark"
"let currentTime = str2nr(strftime("%H"))

"if currentTime < nightBegin && currentTime < dayBegin
"    silent execute "colorscheme " . nightScheme
"elseif currentTime > nightBegin && currentTime > dayBegin
"    silent execute "colorscheme " . nightScheme
"else
"    silent execute "colorscheme " . dayScheme
"endif

set guioptions-=T

set guifont=Monaco\ 10
set linespace=1

set wildmenu
set wcm=<Tab> 
menu Encoding.utf-8 :e ++enc=utf8 <CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
