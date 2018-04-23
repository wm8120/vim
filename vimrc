"""" some common used config """"
syntax on
filetype plugin indent on
set number
set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
set smartcase
set updatetime=800


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


" Remove trailing empties on save
autocmd BufWritePre <buffer> :%s/\s\+$//ec


"""" ctags config """"
set tags=./.tags;,.tags


"""" gutentags for auto tag update """"
" recursively upward search such folders to determine project root
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" name of the generated file
let g:gutentags_ctags_tagfile = '.tags'

" put the auto generated files into ~/.cache/tags
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" create ~/.cache/tags if not exists
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" ctags options
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

