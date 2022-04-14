 "        __     _
 "       / /    (_)
 "      / /_   ___ _ __ ___  _ __ ___
 "     / /\ \ / / | '_ ` _ \| '__/ __|
 "  _ / /  \ V /| | | | | | | | | (__
 " (_)_/    \_/ |_|_| |_| |_|_|  \___|
 "
 " ~ M. Thomas

let mapleader = "\<Space>"

" ============================== vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin()

Plug 'rakr/vim-one' " color scheme
Plug 'tpope/vim-sleuth' " heuristic file indendation
Plug 'jiangmiao/auto-pairs' " pair completion

call plug#end()
" ============================== Colors
syntax on
set background=light
colorscheme one
hi Normal guibg=NONE ctermbg=NONE

" ============================== General
filetype indent plugin on
set number " show line number
set relativenumber " show relative line number
set cursorline " highlight current line
set ruler " show line and row at bottom right

set showmatch " highlights paranthesis
set hidden " allow moving to a new buffer without saving
set mat=5 " idk
set colorcolumn=1337
set noswapfile " can be problematic on some systems
set confirm " can't quit without saving
set noshowmode " don't show mode in status
set noshowcmd " don't show command in status
set encoding=utf-8
set mouse=a " a=on, c=off
set undolevels=1337
set backspace=indent,eol,start " openbsd doesnt let me delete stuff
set wildmenu " autocomplete :e
set scrolloff=5 " min lines above or below the cursor

" ============================== Statusline
set laststatus=1 " i dont need a statusline
set showtabline=1 " tabline

" ============================== Indents and Whitespaces
set list
set listchars=tab:──\ ,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars+=vert:\  "don't draw verticle split

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" ============================== Search
set incsearch " incremental search
set ignorecase " ignore case
set smartcase "  -> unless capitol letters
set hlsearch " highlight all results

" ============================== Cursor Thiccness
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" ============================== netrw
let g:netrw_winsize = 25 " width
let g:netrw_liststyle = 3 " Tree-like structure
let g:netrw_banner = 0 " Remove useless banner at the top of netrw

" ============================== Macros and Mappings
cmap Wq wq
cmap Q q
cmap W w
cmap q1 q!
