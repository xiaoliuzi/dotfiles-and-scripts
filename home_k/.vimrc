" Github: https://github.com/Karmenzind/dotfiles-and-scripts
" --------------------------------------------
" general keymaps and abbreviations
" --------------------------------------------

noremap <Leader>e  :tabe   $MYVIMRC<CR>
noremap <Leader>R  :source $MYVIMRC<CR> :echom 'Vimrc reloaded :)'<CR>
noremap <Leader>S  :source %<CR> :echom expand('%') . ' sourced :)'<CR>

" (TODO: move to snippets)
augroup AbbreForVim
  au!
  autocmd FileType vim :iabbrev <buffer> /* /*<space>*/<left><left><left>
augroup END

" /* workspace, layout, format and others */
" use <Leader>s as 'set' prefix
" toggle wrap-mode
nnoremap <silent> <Leader>sw :set wrap!<CR> :set wrap?<CR>
" toggle backgroud
nnoremap <silent> <Leader>sb :call BackgroudToggle()<CR>

" /* input */
" inoremap <c-d> <delete>
nnoremap <leader><CR> i<CR><ESC>k$

" --------------------------------------------
"  plugin manager
" --------------------------------------------

" automatically install Plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload &&
        \ wget https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        \ -O ~/.vim/autoload/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'junegunn/vim-plug'

" /* coding tools */
Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'junegunn/vim-easy-align'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang --go-completer --js-completer --java-completer' }
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'Shougo/context_filetype.vim'
Plug 'majutsushi/tagbar'
Plug 'Shougo/echodoc.vim'
Plug 'w0rp/ale' " Asynchronous Lint Engine
" Plug 'terryma/vim-multiple-cursors'
" Plug 'junegunn/rainbow_parentheses.vim'
" Plug 'Valloric/MatchTagAlways'

" /* version control | workspace */
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 't9md/vim-choosewin'
Plug 'mhinz/vim-startify'
" Plug 'junegunn/gv.vim'
" Plug 'bagrat/vim-workspace' " tab bar

" /* Search */
Plug 'mileszs/ack.vim'
Plug 'Yggdroot/LeaderF'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-slash' " enhancing in-buffer search experience
" Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
" Plug 'junegunn/fzf', {'dir': '~/.local/fzf', 'do': './install --all'}
" Plug 'haya14busa/vim-signjk-motion'

" /* Python */
Plug 'tmhedberg/SimpylFold', { 'for': 'python' } " code folding
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'plytophogy/vim-virtualenv', { 'for': 'python' }
" Plug 'python-mode/python-mode', { 'for': 'python' }

" /* Write doc */
Plug 'godlygeek/tabular'
Plug 'mzlogin/vim-markdown-toc', { 'for': 'markdown' }
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'iamcco/mathjax-support-for-mkdp', { 'for': 'markdown' }
Plug 'iamcco/markdown-preview.vim', { 'for': 'markdown' }
Plug 'nelstrom/vim-markdown-folding', { 'for': 'markdown' }
Plug 'mklabs/vim-markdown-helpfile'
Plug 'Traap/vim-helptags'
" Plug 'scrooloose/vim-slumlord'

" /* Experience */
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }
Plug 'vim-scripts/fcitx.vim', {'for': 'markdown'} " keep and restore fcitx state when leaving/re-entering insert mode
" Plug 'junegunn/limelight.vim'
" Plug 'terryma/vim-smooth-scroll'

" /* Mine */
Plug 'karmenzind/vim-tmuxlike'

" /* Funny Stuff */
Plug 'junegunn/vim-emoji', { 'for': 'markdown,gitcommit' }

" /* Games*/
" Plug 'vim-scripts/TeTrIs.vim'

" /* Syntax */
" Plug 'vim-scripts/txt.vim', { 'for': 'txt' }

" /* Appearance */
Plug 'flazz/vim-colorschemes', { 'do': 'rsync -avz ./colors/ ~/.vim/colors/ && rm -rf ./colors/*' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons' " load after other plugins
Plug 'gerardbm/vim-atomic'
" Plug 'chxuan/change-colorscheme', { 'on': 'NextColorScheme' }

call plug#end()

" --------------------------------------------
" basic
" --------------------------------------------

" load vim default plugin
runtime macros/matchit.vim

" /* base */
set nocompatible
set noerrorbells
" set report=0
set showcmd " This shows what you are typing as a command.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.png,.jpg

" /* appearence */
" set termguicolors
set wildmenu
set ruler
set showtabline=1
set guifont=Hack\ Nerd\ Font\ 12
set cursorline
" highlight CursorLine guibg=darkgray ctermbg=black
" set noshowmode
set showmode
set cmdheight=2
set laststatus=2
" set whichwrap+=<,>,h,l
set matchtime=5
" set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]
set statusline=%f\ %{WebDevIconsGetFileTypeSymbol()}\ %h%w%m%r\ %=%(%l,%c%V\ %Y\ %=\ %P%)

" /* line number */
set number
augroup relative_number_toggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set rnu
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * set nornu
augroup END

" /* layout */
set splitbelow splitright

" /* operate and edit */
set mouse=a
set backspace=indent,eol,start  " more powerful backspacing
" make * reg the default
if has('clipboard')
  set clipboard=unnamed
endif
set scrolloff=5

" /* Enable folding */
" set foldmethod=indent
set foldmethod=manual
set foldlevel=99

" /* spell check */
set spelllang=en nospell

" /* cache and swap */
set history=50
set nobackup
" set noswapfile
" set autoread
" set autowrite
" set confirm
" Move the swap file location to protect against CVE-2017-1000382
" if exists('$XDG_CACHE_HOME')
" 	let &g:directory=$XDG_CACHE_HOME
" else
" 	let &g:directory=$HOME . '/.cache'
" endif
" let &g:directory.='/vim/swap//'
" " Create swap directory if it doesn't exist
" if ! isdirectory(expand(&g:directory))
"   silent! call mkdir(expand(&g:directory), 'p', 0700)
" endif

" /* persistent undo */
" set undodir=~/.vim/persistence/undo//
" set backupdir=~/.vim/persistence/backup//
" set directory=~/.vim/persistence/swp//
" set undofile

" --------------------------------------------
" format and syntax
" --------------------------------------------

syntax enable
" syntax on
" filetype plugin indent on

set termencoding=utf-8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
set encoding=utf-8

set iskeyword+=_,$,@,%,#,-
set fileformat=unix
set shiftwidth=4

set expandtab
set smarttab
set tabstop=4
set softtabstop=4

" for different file types
augroup filetype_formats
  au!

  au FileType help setlocal nu

  au BufNewFile,BufRead *.{vim,vimrc}
        \ setlocal foldmethod=marker |
        \ setlocal tabstop=2         |
        \ setlocal softtabstop=2     |
        \ setlocal shiftwidth=2

  au BufNewFile,BufRead *.py
       \ setlocal autoindent      |
       \ setlocal nowrap          |
       \ setlocal sidescroll=5    |
       \ let g:python_highlight_all = 1 |
       \ setlocal complete+=t |
       \ setlocal formatoptions-=t |
       \ setlocal nowrap |
       \ setlocal commentstring=#%s |
       \ setlocal define=^\s*\\(def\\\\|class\\)
       " \ set listchars+=precedes:<,extends:>
       " \ set textwidth=79 |

  au BufNewFile,BufRead *.js,*.html,*.css,*.yml
      \ setlocal tabstop=2     |
      \ setlocal softtabstop=2 |
      \ setlocal shiftwidth=2

  " autocmd BufNewFile,BufRead *.{md,mkd,mkdn,mark*}
  "   \ set filetype=markdown

  " useless whitespaces
  au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.{vim,vimrc}
      \ highlight BadWhitespace ctermbg=red guibg=darkred |
      \ match BadWhitespace /\s\+$/

augroup END

" --------------------------------------------
" Header
" --------------------------------------------

" /* file headers */
augroup AddFileHeaders
  au!
  au BufNewFile *.sh
        \ call setline(1, '#!/usr/bin/env bash') |
        \ call append(line('.'), '')             |
        \ normal! Go
  au BufNewFile *.py
        \ call setline(1, '#!/usr/bin/env python')          |
        \ call append(line('.'), '# -*- coding: utf-8 -*-') |
        \ call append(line('.')+1, '')                      |
        \ normal! Go
  au BufNewFile *.{cpp,cc}
        \ call setline(1, '#include <iostream>') |
        \ call append(line('.'), '')             |
        \ normal! Go
  au BufNewFile *.c
        \ call setline(1, '#include <stdio.h>') |
        \ call append(line('.'), '')            |
        \ normal! Go
  au BufNewFile *.h,*.hpp
        \ call setline(1, '#ifndef _'.toupper(expand('%:r')).'_H') |
        \ call setline(2, '#define _'.toupper(expand('%:r')).'_H') |
        \ call setline(3, '#endif')                                |
        \ normal! Go
augroup END

" --------------------------------------------
" GUI
" --------------------------------------------

if has('gui_running')
  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>
endif

" --------------------------------------------
" for ycm
" --------------------------------------------

if empty(glob('~/.vim/.ycm_extra_conf.py'))
  silent !wget https://raw.githubusercontent.com/Karmenzind/dotfiles-and-scripts/master/home_k/.vim/.ycm_extra_conf.py
    \ -O ~/.vim/.ycm_extra_conf.py
endif

let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1
      \}

set completeopt-=preview
set completeopt+=longest,menu
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1

let g:ycm_max_num_candidates = 10
let g:ycm_max_num_identifier_candidates = 5
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_server_python_interpreter = '/usr/bin/python'
let g:ycm_python_binary_path = 'python'
let g:ycm_goto_buffer_command = 'horizontal-split'

" let g:ycm_seed_identifiers_with_syntax = 1
" let g:ycm_collect_identifiers_from_tags_files = 1
" let g:ycm_collect_identifiers_from_comments_and_strings = 1

nnoremap <silent> <Leader>gt  :YcmCompleter GoTo<CR>
nnoremap <silent> <Leader>dd  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <silent> <Leader>rf  :YcmCompleter GoToReferences<CR>
nnoremap <silent> <Leader>doc :YcmCompleter GetDoc<CR>

" --------------------------------------------
" for NERDTree
" --------------------------------------------

nnoremap <silent> <Leader>n :NERDTreeToggle<CR>

let g:NERDTreeIgnore = ['\.pyc$', '\~$', '__pycache__[[dir]]']

augroup nerd_behaviours
  au!
  autocmd StdinReadPre * let s:std_in = 1
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
  autocmd tableave * if exists('g:loaded_nerd_tree') | execute 'NERDTreeClose' | endif
augroup END

let g:NERDTreeNaturalSort = 1
let g:NERDTreeShowLineNumbers = 1
let g:NERDTreeShowHidden = 1

" --------------------------------------------
" other plugin config
" --------------------------------------------

" /* For Markdown-preview */
let g:mkdp_path_to_chrome = '/usr/bin/chromium'
" callback vim function to open browser, the only param is the url to open
let g:mkdp_browserfunc = 'MKDP_browserfunc_default'
" open the preview window once enter the markdown buffer
let g:mkdp_auto_start = 0
" auto open preview window when you edit the markdown file
let g:mkdp_auto_open = 0
" auto close current preview window when changeto another buffer
let g:mkdp_auto_close = 1
" refresh markdown when save the buffer or leave from insert mode
let g:mkdp_refresh_slow = 0
" use the MarkdownPreview command for all files
let g:mkdp_command_for_global = 0

" /* For vim-airline */
nnoremap <Leader>A :AirlineToggle<CR>:AirlineRefresh<CR>
let g:airline_powerline_fonts = 1
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_mode_map = {
     \ '__' : '-',
     \ 'n'  : 'N',
     \ 'i'  : 'I',
     \ 'R'  : 'R',
     \ 'c'  : 'C',
     \ 'v'  : 'V',
     \ 'V'  : 'V',
     \ '' : 'V',
     \ 's'  : 'S',
     \ 'S'  : 'S',
     \ '' : 'S',
     \ 't'  : 'T',
     \ }
let g:airline_highlighting_cache = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#ale#enabled = 0
let g:airline#extensions#branch#enabled = 0
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#hunks#enabled = 0
" let g:airline#extensions#hunks#non_zero_only = 1

" /* For vim-virtualenv */
let g:virtualenv_directory = '~/Envs'

" /* for LeaderF */
" let g:Lf_ShortcurF = '<Leader>n'
nnoremap <Leader>ff :LeaderfFile<CR>
highlight Lf_hl_match gui=bold guifg=Blue cterm=bold ctermfg=21
highlight Lf_hl_matchRefine  gui=bold guifg=Magenta cterm=bold ctermfg=201
let g:Lf_WindowPosition = 'bottom'
let g:Lf_DefaultMode = 'FullPath'
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_WildIgnore = {
      \  'dir': ['.svn','.git','.hg', '.idea', '__pycache__'],
      \  'file': ['*.sw?','~$*','*.exe','*.o','*.so','*.py[co]']
      \ }
let g:Lf_MruFileExclude = ['*.so']
let g:Lf_UseVersionControlTool = 0

" /* for Ack */
nnoremap <Leader>fc :Ack!<space>
" if executable('ag')
"   let g:ackprg = 'ag --vimgrep'
" endif

" /* for vim-slash  */
" noremap <plug>(slash-after) zz

" /* for vim-smooth-scroll */
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 0, 4)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 0, 4)<CR>

" /* for tagbar */
noremap <Leader>t :TagbarOpenAutoClose<CR>
noremap <Leader>T :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_show_linenumbers = 1

" /* for devicons */
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
" let g:WebDevIconsOS = 'ArchLinux'

" /* for startify */
function! StartifyEntryFormat()
  return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction

" /* for vim-easy-align */
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" /* for vim-emoji */
set completefunc=emoji#complete

" /* for echodoc.vim */
" let g:echodoc_enable_at_startup = 1
" let g:echodoc#enable_force_overwrite = 1

" /* for easymotion */
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" /* for ultisnips */
let g:UltiSnipsExpandTrigger = '<c-j>'
let g:UltiSnipsListSnippets = '<F9>'
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsSnippetsDir = $HOME . '/.vim/mysnippets'
let g:UltiSnipsSnippetDirectories=['UltiSnips', 'mysnippets']
let g:UltiSnipsEnableSnipMate = 1
let g:snips_author = 'k'
let g:snips_email = 'valesail7@gmail.com'
let g:snips_github = 'https://github.com/Karmenzind/'

" /* for colorscheme */
" noremap <Leader>c :NextColorScheme<CR>:colorscheme<CR>
" noremap <Leader>C :PreviousColorScheme<CR>:colorscheme<CR>

" /* for ale */
nmap <silent> <C-k> <Plug>(ale_previous)
nmap <silent> <C-j> <Plug>(ale_next)
nmap <silent> <Leader>fix <Plug>(ale_fix)
let g:ale_linters = {
      \  'markdown': ['mdl', 'prettier', 'proselint', 'alex'],
      \  'text': ['proselint', 'alex', 'redpen'],
      \  'sql': ['sqlint'],
      \  'cpp': ['gcc']
      \ }
let g:ale_fixers = {
      \  'vim': [
      \    'trim_whitespace'
      \  ],
      \  'python': [
      \    'autopep8',
      \    'isort',
      \    'add_blank_lines_for_python_control_statements',
      \    'trim_whitespace'
      \  ],
      \  'sh': [
      \    'shfmt',
      \    'trim_whitespace'
      \  ]
      \ }

" /* for vim-multiple-cursors */
" if !has('gui_running')
"   map "in Insert mode, type Ctrl+v Alt+n here" <A-n>
" endif

" /* for vim-markdown */
let g:vim_markdown_toc_autofit = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_json_frontmatter = 1
augroup for_markdown_ft
  au!
  au FileType markdown :nnoremap <Leader>t :Toc<CR>
  au FileType markdown :nnoremap <Leader>T :Toc<CR>
augroup END

" /* for Game */
" silent! nunmap <Leader>te
" " have fun
" nnoremap <silent> <Leader>hf :call <SNR>55_Main()<CR>

" /* for signjk-motion */
" map <Leader>j <Plug>(signjk-j)
" map <Leader>k <Plug>(signjk-k)

" /* for SimpylFold */
let g:SimpylFold_docstring_preview = 1

" /* for choosewin */
" invoke with '-'
" nmap  -  <Plug>(choosewin)
" " if you want to use overlay feature
" let g:choosewin_overlay_enable = 1

" /* for vim-tmuxlike */
nmap <silent> <c-\> <Plug>(tmuxlike-prefix)

" /* for vim-plug */
noremap <Leader>pi :PlugInstall<CR>
noremap <Leader>pu :PlugUpdate<CR>
noremap <Leader>ps :PlugStatus<CR>
noremap <Leader>pc :PlugClean<CR>

nnoremap <S-F9> :call CycleModes()<CR>:colorscheme atomic<CR>
vnoremap <S-F9> :<C-u>call CycleModes()<CR>:colorscheme atomic<CR>gv

" --------------------------------------------
" colorscheme
" --------------------------------------------

" /* basic */
" italic
" set t_ZH=[3m
" set t_ZR=[23m
" enhance termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

function! SetTermguiColors(k)
  if a:k ==# 'yes'
      if &termguicolors == 0 && has('termguicolors')
        set termguicolors
      endif
  elseif &termguicolors == 1
      set notermguicolors
  endif
endfunction

" /* background */
function! BackgroudToggle()
  if &background ==# 'dark'
    set background=light
  elseif &background ==# 'light'
    set background=dark
  endif
endfunction

function! LetBgFitClock()
  let b:current_hour = strftime('%H')
  if b:current_hour >=8 && b:current_hour <= 16
    set background=light
  else
    set background=dark
  endif
endfunction

" /* for solarized color */
" let g:solarized_termcolors=256
" let g:solarized_termtrans=1

" /* for atomic */
let g:atomic_mode = 3

function! AfterChangeColorscheme()
  " highlight
  highlight Comment cterm=italic
endfunction

augroup fit_colorscheme
  au!
  au ColorSchemePre * call SetTermguiColors('no')
  au ColorSchemePre atomic,NeoSolarized call SetTermguiColors('yes')
  au ColorScheme * call AfterChangeColorscheme()
augroup END

" gruvbox bubblegum birds-of-paradise blaquemagick buddy_modified dante
" eclipse darkburn enigma eva01 evening evolution apprentice
function! InitColors()
  if &termguicolors == 0 && has('termguicolors')
    set termguicolors
    colorscheme atomic
  else
    colorscheme solarized
  endif
endfunction

" /* initial */
" colorscheme solarized
call InitColors()
call LetBgFitClock()
call AfterChangeColorscheme()
