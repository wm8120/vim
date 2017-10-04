"""" global variables """"
" for 256 colors terminal
if $TERM == 'xterm-256color' || $TERM == 'screen' || $TERM == 'screen-256color'
   set t_Co=256
endif

" italic support
let s:italic_support = 0
if $TERM == 'xterm-256color' || $TERM == 'xterm-256color-italic' || $TERM == 'screen-256color-italic'
    let s:italic_support = 1
endif


"""" some common used config """"
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
syntax on
filetype plugin indent on
set number
set ruler
set ignorecase
set incsearch
set smartcase
set updatetime=800


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

set background=dark     "bg can set to light or dark
call togglebg#map("<F5>")   "use the key within quote to toggle light or dark bg

colorscheme Tomorrow-Night-Bright

"" pencil adaption ""
if g:colors_name == 'pencil' && s:italic_support == 1
    let g:pencil_terminal_italics = 1
    colorscheme pencil " refresh for italic can take effect
endif


""""" Italic Setting """""
" note that ^[ are not literal characters but represent the escape character, it can be insertet with CTRL-V followed by ESC (see :help i_CTRL-V)
if $TERM == 'xterm-256color'
    set t_ZH=[3m
    set t_ZR=[23m
endif
if s:italic_support == 1
    highlight Comment cterm=italic
endif


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
"rebuild the .spl file each time the .add file has been updated when vim is started
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        exec 'mkspell! ' . fnameescape(d)
    endif
endfor


""""" taglist config """""
" nmap <silent> <F9> :TlistToggle<cr>
" let Tlist_Exit_OnlyWindow = 1       "exit when taglist is the last open window
" let Tlist_Use_Right_Window = 1      "show on right side
" let Tlist_WinWidth = 40             "default window width 
" autocmd CursorMovedI * silent! TlistHighlightTag
"

""""" tagbar config """""
nmap <silent> <F9> :TagbarToggle<cr>


""""" NERDTree config """""
nmap <silent> <F8> :NERDTreeToggle<cr>
"exit when NERDTree is the last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


"""" vimtex config """"
let g:vimtex_latexmk_callback = 0


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
