"for 256 colors terminal
if $TERM == 'xterm-256color'
  set t_Co=256
endif

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

set number
set bg=dark
colorscheme solarized
set ruler

"cscope
	nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
	nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
	nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
	nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>

"for python indent
set expandtab
set softtabstop=4

"indent
set shiftwidth=4
set autoindent

"taglist config
nmap <silent> <F9> :TlistToggle<cr>
let Tlist_Exit_OnlyWindow = 1       "exit when taglist is the last open window

"always show status bar
"set statusline=%2*%n%m%r%h%w%*\ %F\ %1*[FORMAT=%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ [TYPE=%2*%Y%1*]\ [COL=%2*%03v%1*]\ [ROW=%2*%03l%1*/%3*%L(%p%%)%1*]
set statusline=%2*%n%m%r%h%w%*\ %F\ %1*[%2*%03v%1*\,%2*%03l%1*/%3*%L(%p%%)%1*]
set ls=2
hi statusline ctermbg=white ctermfg=black
