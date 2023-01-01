" ~/.vimrc
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

Plug 'tpope/vim-sleuth'                 " heuristic file indendation
Plug 'jiangmiao/auto-pairs'             " pair completion
Plug 'ctrlpvim/ctrlp.vim'               " file finder
Plug 'tpope/vim-fugitive'               " git wrapper

Plug 'sainnhe/everforest'               " color scheme
Plug 'vim-airline/vim-airline'          " a nicer status line
Plug 'vim-airline/vim-airline-themes'   " auto settings theme for airline

call plug#end()
" ============================== Colors
syntax on
set background=light
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1
" let g:everforest_enable_italic = 1
colorscheme everforest
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

" ============================== General
filetype indent plugin on
set number                     " show line number
set relativenumber             " show relative line number
set cursorline                 " highlight current line
set ruler                      " show line and row at bottom right
set colorcolumn=80
set nowrap                     " don't wrap lines

set showmatch                  " highlights paranthesis
set hidden                     " allow moving to a new buffer without saving
set noswapfile                 " don't create a swap file
set confirm                    " can't quit without saving
set noshowmode                 " don't show mode in status
set noshowcmd                  " don't show command in status
set encoding=utf-8
set mouse=a                    " a=on, c=off
set undolevels=1337
set backspace=indent,eol,start " always delete with backspace
set wildmenu                   " autocomplete :e
set scrolloff=5                " minimum lines above or below the cursor

let g:ctrlp_show_hidden = 1    " show hidden files in ctrlp menus

" ============================== Statusline
set laststatus=1  " 1: only if there are at least two windows
set showtabline=1 " 1: only if there are at least two tab pages
let g:airline_powerline_fonts = 1

" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tabs_label = '裡'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_count = 0

let g:airline_mode_map = {
    \ 'i'      : '',
    \ 'ic'     : '',
    \ 'ix'     : '',
    \ 'n'      : '',
    \ 'multi'  : '並',
    \ 'ni'     : '',
    \ 'no'     : '',
    \ 'R'      : 'ﰇ',
    \ 'Rv'     : 'ﰇ',
    \ 'v'      : '',
    \ 'V'      : ' ',
    \ '␖'     : ' 麗',
    \ 'c'      : ''
    \ }

" ============================== Indents and Whitespaces
set list
set listchars=tab:──\ ,extends:›,precedes:‹,nbsp:·,trail:· " show chars for whitespaces
set fillchars+=vert:\                                      " don't draw verticle split

" show trailing whitespaces in red
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+\%#\@<!$/

" ============================== Search
set incsearch  " incremental search
set ignorecase " ignore case
set smartcase  "  -> unless capitol letters
set hlsearch   " highlight all results
set mat=5

" ============================== Cursor Thiccness
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" ============================== netrw
let g:netrw_winsize = 25  " width
let g:netrw_liststyle = 3 " Tree-like structure
let g:netrw_banner = 0    " Remove useless banner at the top of netrw

" ============================== Macros and Mappings
" open fuzzy file browser
map <C-f> :CtrlP .<CR>
" C-/ to hide search results
map <C-_> :noh<CR>
" git
map <leader>gs :Git status<CR>
map <leader>gb :Git blame<CR>
map <C-s> :Git grep 

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
noremap <leader>ws :call TrimWhitespace()<CR>
