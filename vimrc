"""" global variables """"
" for 256 colors terminal such as 'xterm-256color' and 'screen-256color'
if $TERM =~ '256color'
    set t_Co=256
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

" italic support
let s:italic_support = 0
if $TERM == 'xterm-256color' || $TERM == 'xterm-256color-italic' || $TERM == 'screen-256color-italic'
    let s:italic_support = 1
endif


"""" some common used config """"
syntax on
filetype plugin indent on
" set number
set ruler
set ignorecase
set smartcase
set hlsearch
set incsearch
set smartcase
set autoread
set updatetime=100
set noshowmode
set splitright
set colorcolumn=120
let loaded_matchparen = 1
let mapleader = ","
nnoremap ,, ,
nnoremap , <NOP>


"""" Refresh buffer when files changes on disk """"
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" Notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None


""""" for python indent """""
set expandtab


""""" prevent expand tab in makefile """""
autocmd FileType make setlocal noexpandtab


"""" prevent colorcolumn shown in quickfix """"
au FileType qf setlocal colorcolumn=
au FileType netrw setlocal colorcolumn=


""""" indent """""
set shiftwidth=4
set autoindent
set smartindent


""""" Color Theme """""
set background=dark     "bg can set to light or dark
" colorscheme Tomorrow-Night
" colorscheme Tomorrow-Night-Bright
" colorscheme Tomorrow-Night-Eighties
" colorscheme primary
" colorscheme elflord
" colorscheme ron
colorscheme wombat256mod


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


"""" Vim jump to the last position when reopening a file """"
if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g'\"" | endif
endif


"""" Remove trailing empties on save, but exclude some file types """"
fun! StripTrailingWhitespace()
    " Only strip if the b:noStripeWhitespace variable isn't set
    if exists('b:noStripWhitespace')
        return
    endif
    %s/\s\+$//ec
endfun

autocmd FileType markdown let b:noStripWhitespace=1
autocmd BufWritePre * call StripTrailingWhitespace()


"""" ctags config """"
set tags=./tags;,tags


"""" gutentags for auto tag update """"
" recursively upward search such folders to determine project root
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" put the auto generated files into ~/.cache/tags
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" create ~/.cache/tags if not exists
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" modules
let g:gutentags_modules = ['ctags']

" ctags options
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']


"""" YouCompleteMe """"
" let g:ycm_add_preview_to_completeopt = 1
" let g:ycm_autoclose_preview_window_after_completion = 0
" let g:ycm_autoclose_preview_window_after_insertion = 0
let g:ycm_show_diagnostics_ui = 1
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_complete_in_comments=1
let g:ycm_key_invoke_completion = '<c-z>'
let g:ycm_confirm_extra_conf = 0
let g:ycm_error_symbol = 'E'
let g:ycm_warning_symbol = 'W'
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
            \ "python":1,
            \ }

" for UltiSnips expansion, remove <tab> and <s-tab> in the list
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']


"""" polyglot """"
" will use vimtex instead
let g:polyglot_disabled = ['latex']
" set markdown indent
let g:vim_markdown_new_list_item_indent = 2


"""" ale """"
let g:ale_linters_explicit = 1
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

" adaptive color for colorschemes
if g:colors_name == 'primary'
    if &background == 'dark'
        let g:airline_theme = 'base16_google'
    else
        let g:airline_theme = 'tomorrow'
    endif
endif

" if g:colors_name == 'ron'
"   let g:airline_theme = 'angr'
"   let g:airline_theme = 'simple'
" endif

" if g:colors_name == 'Tomorrow-Night-Eighties'
if g:colors_name == 'wombat256mod'
    autocmd VimEnter * hi Normal ctermbg=none
    autocmd VimEnter * hi NonText ctermbg=none
    autocmd VimEnter * hi LineNr ctermbg=none
    autocmd VimEnter * hi GitGutterAddDefault ctermbg=none
    autocmd VimEnter * hi GitGutterChangeDefault ctermbg=none
    autocmd VimEnter * hi GitGutterChangeDeleteDefault ctermbg=none
    autocmd VimEnter * hi GitGutterDeleteDefault ctermbg=none
endif

"""" key bindings """"
nnoremap <silent> <F3> :YcmCompleter GoTo<cr>
nnoremap <silent> <F4> :Ack! "\b<c-r><c-w>\b"
nnoremap <silent> <Leader>gf :YcmCompleter GoToInclude<cr>
nnoremap <silent> <Leader>ft :YcmCompleter FixIt<cr>
nnoremap <silent> <c-p> :Files<cr>
nnoremap <silent> <Leader>ag :Ag<cr>
nnoremap <silent> <F8> :Vex!<cr>
nnoremap <silent> <F9> :BTags<cr>
nnoremap <silent> <F10> :packadd vim-gutentags<cr>
nnoremap <silent> <Leader>ve :Vex<cr>
nnoremap <silent> <Leader>se :Sex<cr>
" manual trigger remove trailing whites
" nnoremap <silent> <Leader>rw :%s/\s\+$//ec<cr>
nnoremap <silent> <Leader>w :w<cr>:pc<cr>
nnoremap <silent> <Leader>bf :Buffers<cr>
" toggle line number
nnoremap <silent> <Leader>ln :set number!<cr>


"""" netrw config """"
let g:netrw_banner = 0


"""" ack.vim config """"
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" key mappings from ':h g:ack_mappings'
let g:ack_mappings = {
            \ "p": "<CR><C-W>j",
            \ "h": "",
            \ "ho": "<C-W><CR><C-W>K",
            \ "H": "",
            \ "gh": "<C-W><CR><C-W>K<C-W>b",
            \ "v": "",
            \ "vo": "<C-W><CR><C-W>H<C-W>b<C-W>J<C-W>t",
            \ "gv": "<C-W><CR><C-W>H<C-W>b<C-W>J",
            \ }


"""" easymotion """"
map <space> <Plug>(easymotion-prefix)


"""" vim-codefmt """"
augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  " autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " autocmd FileType python AutoFormatBuffer autopep8
augroup END
vnoremap <silent> <leader>f :FormatLines<cr>


"""" cycling buffers """"
nnoremap <silent> <c-tab> :bnext<CR>
nnoremap <silent> <s-tab> :bprevious<CR>


"""" ultisnips """"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


"""" CompleteParameters """"
inoremap <silent><expr> <c-b> complete_parameter#pre_complete("()")
" let g:complete_parameter_use_ultisnips_mappings = 0
let g:complete_parameter_echo_signature = 0
nmap <c-j> <Plug>(complete_parameter#goto_next_parameter)
imap <c-j> <Plug>(complete_parameter#goto_next_parameter)
smap <c-j> <Plug>(complete_parameter#goto_next_parameter)
nmap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
imap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
smap <c-k> <Plug>(complete_parameter#goto_previous_parameter)
