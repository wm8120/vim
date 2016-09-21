"for 256 colors terminal
"try to comment out the conditional branch and use let &t_Co=256 instead
if $TERM == 'xterm-256color'
   set t_Co=256
endif

"let &t_Co=256

"""" some common used config """"
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
set number
set ruler
syntax on
filetype indent on


"""" save tmp files to another folder """"
if !isdirectory($HOME."/.vimtmps")
    call mkdir($HOME."/.vimtmps/backup", "p")
    call mkdir($HOME."/.vimtmps/swap", "p")
    call mkdir($HOME."/.vimtmps/undo", "p")
endif
"" specifying two trailing slashes, vim will create swap files
"" using the whole path of the files being edited to avoid collisions
set backupdir=$HOME/.vimtmps/backup//
set directory=$HOME/.vimtmps/swap//
set undodir=$HOME/.vimtmps/undo//


" Uncomment the following to have Vim jump to the last position when                                
" reopening a file
if has("autocmd")
   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif


""""" Color Theme """""

"" molokai theme config ""
" let g:molokai_original = 1     " to match original background color
" let g:rehash256 = 1     "under development version, targeting to aproach GUI version

"" solarized config ""
set background=dark     "bg can set to light or dark
" call togglebg#map("<F5>")   "use the key within quote to toggle light or dark bg
"let g:solarized_termcolors=256 "for the terminal without custom solarized theme

colorscheme gardener


""""" for python indent """""
set expandtab
set softtabstop=4


""""" prevent expand tab in makefile """""
autocmd FileType make setlocal noexpandtab


""""" indent """""
set shiftwidth=4
set autoindent


""""" specll check """""
:map <silent> <F7> :setlocal spell! spelllang=en_us<cr>


""""" taglist config """""
nmap <silent> <F9> :TlistToggle<cr>
let Tlist_Exit_OnlyWindow = 1       "exit when taglist is the last open window
let Tlist_Use_Right_Window = 1      "show on right side
let Tlist_WinWidth = 40             "default window width 
autocmd CursorMovedI * silent! TlistHighlightTag


""""" NERDTree config """""
nmap <silent> <F8> :NERDTreeToggle<cr>
"exit when NERDTree is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


"""" Mouse config """""
set ttyfast
set mouse=a
set ttymouse=xterm2


""""" vim-airline """""
set ttimeoutlen=50 "reduce the pause when leaving insert mode
set laststatus=2  "always show status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1
