"""" global variables """"
" for 256 colors terminal such as 'xterm-256color' and 'screen-256color'
if $TERM =~ '256color'
    set t_Co=256
endif

" italic support
let s:italic_support = 0
if $TERM == 'xterm-256color' || $TERM == 'xterm-256color-italic' || $TERM == 'screen-256color-italic'
    let s:italic_support = 1
endif


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


""""" Color Theme """""
set background=light     "bg can set to light or dark
colorscheme Tomorrow-Night-Bright


""""" Italic Setting """""
" note that ^[ are not literal characters but represent the escape character, it can be insertet with CTRL-V followed by ESC (see :help i_CTRL-V)
if $TERM == 'xterm-256color'
    set t_ZH=[3m
    set t_ZR=[23m
endif
if s:italic_support == 1
    highlight Comment cterm=italic
endif


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


"""" YouCompleteMe """"
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ }

" white list to allow ycm run
let g:ycm_filetype_whitelist = {
            \ "c":1,
            \ "cpp":1,
            \ "h":1,
            \ "hpp":1,
            \ "sh":1,
            \ }


"""" echodoc """"
" set no show mode to prevent overlap function signation
" mode can still be viewed in vim-airline
set noshowmode
let g:echodoc_enable_at_startup = 1


"""" polyglot """"
" will use vimtex instead
let g:polyglot_disabled = ['latex']


"""" ale """"
" let g:ale_linters_explicit = 1
" let g:ale_linters = {
" 	    \'c': ['gcc', 'cppcheck'],
" 	    \'cpp': ['gcc', 'cppcheck'],
" 	    \}
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''


"""" vim-airline """"
set ttimeoutlen=50 "reduce the pause when leaving insert mode
set laststatus=2  "always show status bar
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
