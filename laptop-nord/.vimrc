" ▄▄   ▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ ▄▄  ▄▄▄▄▄▄▄    ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄
" █  █▄█  █      █   ▄  █ █       █  ██       █  █  █ █  █   █  █▄█  █   ▄  █ █       █
" █       █  ▄   █  █ █ █ █       █▄▄██  ▄▄▄▄▄█  █  █▄█  █   █       █  █ █ █ █       █
" █       █ █▄█  █   █▄▄█▄█     ▄▄█   █ █▄▄▄▄▄   █       █   █       █   █▄▄█▄█     ▄▄█
" █       █      █    ▄▄  █    █      █▄▄▄▄▄  █  █       █   █       █    ▄▄  █    █
" █ ██▄██ █  ▄   █   █  █ █    █▄▄     ▄▄▄▄▄█ █   █     ██   █ ██▄██ █   █  █ █    █▄▄
" █▄█   █▄█▄█ █▄▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█   █▄▄▄▄▄▄▄█    █▄▄▄█ █▄▄▄█▄█   █▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█
"

let mapleader = "\<Space>"

" ============================== Plugins
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Show git changes
Plugin 'airblade/vim-gitgutter'

" Automatic intendations
Plugin 'tpope/vim-sleuth'

" Match parents
Plugin 'tmsvg/pear-tree'

let g:pear_tree_smart_openers=1
let g:pear_tree_smart_closers=1
let g:pear_tree_smart_backspace=1

let g:pear_tree_pairs = {
            \ '(': {'closer': ')'},
            \ '[': {'closer': ']'},
            \ '{': {'closer': '}'},
            \ "'": {'closer': "'"},
            \ '"': {'closer': '"'},
            \ '<': {'closer': '>'}
            \ }

" fzf
if executable("fzf")
    Plugin 'junegunn/fzf'
    Plugin 'junegunn/fzf.vim'

    nmap <C-f> :Files<CR>
endif

" Colors
Plugin 'arcticicestudio/nord-vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

let g:airline_theme='nord'
let g:airline_powerline_fonts = 1
let g:bufferline_echo = 0
set guifont="FiraCode Nerd Font Mono"

call vundle#end()
filetype plugin indent on

" ============================== Colors
syntax on
colorscheme nord
filetype indent plugin on

"set termguicolors
"let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" ============================== General
set number
set relativenumber
set cursorline
set ruler

set showmatch " highlights paranthesis
set mat=5
set noswapfile " can be problematic on some systems
set confirm " can't quit without saving
set noshowmode " don't show mode in status
set noshowcmd " don't show command in status
set encoding=utf-8
set mouse=c
set undolevels=1337 " memegods can make mistakes
set backspace=indent,eol,start
set wildmenu " autocomplete :e

" ============================== Indents and Whitespaces
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" ============================== Search
set incsearch
set ignorecase
set smartcase " case sensitive when capital letters are used
set hlsearch " highlight all results
nnoremap<leader><space> :nohlsearch<CR>

" ============================== Cursor Thiccness
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" ============================== netrw
let g:netrw_winsize = 25
let g:netrw_liststyle = 3 " Tree-like structure
let g:netrw_banner = 0 " Remove useless banner at the top of netrw

" ============================== Macros and Mappings
cmap Wq wq
cmap Q q
cmap W w
cmap q1 q!
