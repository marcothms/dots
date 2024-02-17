" ~/.vimrc
"
" caveats in config start with XXX
"
" ~ M. Thomas

let mapleader = "\<Space>"

" ============================== vim-plug
let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source ~/.vimrc
endif

call plug#begin()

" essentials
Plug 'jiangmiao/auto-pairs'             " pair completion
Plug 'mhinz/vim-signify'                " show lines changed in git(1)
Plug 'tpope/vim-commentary'             " DWIM comments
Plug 'sheerun/vim-polyglot'             " language packs (highlighting, indent)

Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'

" colors
Plug 'sainnhe/everforest'               " color scheme
Plug 'vim-airline/vim-airline'          " nicer status line
Plug 'vim-airline/vim-airline-themes'   " auto settings theme for airline

call plug#end()

" ============================== Colors
syntax on
set background=light
let g:everforest_background = 'medium'
let g:everforest_better_performance = 1
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

autocmd FileType c setlocal tabstop=4 shiftwidth=4 noexpandtab

let g:ctrlp_show_hidden = 1    " show hidden files in ctrlp menus
let g:fzf_preview_window = ['down,50%', 'ctrl-/']

let g:LanguageClient_useFloatingHover = 1 " prevent buggy split preview from opening

" ============================== Statusline
let g:airline_section_x = airline#section#create([])
let g:airline_section_y = airline#section#create_right(['%{&fileencoding}', '%{&fileformat}', '%{&filetype}'])
let g:airline_section_z = airline#section#create(['%{line(".")}:%{col(".")}'])

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

" ============================== Macros and Mappings

map <Leader>f :GFiles<CR>
map <Leader>F :Files<CR>

command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview(), <bang>0)
if has("linux")
    map <C-/> :GGrep 
else
    " for some reason, openbsd doesnt like fzf live commands
    map <C-/> :GGrep 
endif

" kill whitespaces fast and efficient
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
noremap <leader>ws :call TrimWhitespace()<CR>

" comment DWIM
map <C-c> :Commentary<CR>

" clear search highlighting faster
map <Esc><Esc> :noh <CR>
