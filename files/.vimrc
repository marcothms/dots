" ▄▄   ▄▄ ▄▄▄▄▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄ ▄▄  ▄▄▄▄▄▄▄    ▄▄   ▄▄ ▄▄▄ ▄▄   ▄▄ ▄▄▄▄▄▄   ▄▄▄▄▄▄▄
" █  █▄█  █      █   ▄  █ █       █  ██       █  █  █ █  █   █  █▄█  █   ▄  █ █       █
" █       █  ▄   █  █ █ █ █       █▄▄██  ▄▄▄▄▄█  █  █▄█  █   █       █  █ █ █ █       █
" █       █ █▄█  █   █▄▄█▄█     ▄▄█   █ █▄▄▄▄▄   █       █   █       █   █▄▄█▄█     ▄▄█
" █       █      █    ▄▄  █    █      █▄▄▄▄▄  █  █       █   █       █    ▄▄  █    █
" █ ██▄██ █  ▄   █   █  █ █    █▄▄     ▄▄▄▄▄█ █   █     ██   █ ██▄██ █   █  █ █    █▄▄
" █▄█   █▄█▄█ █▄▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█   █▄▄▄▄▄▄▄█    █▄▄▄█ █▄▄▄█▄█   █▄█▄▄▄█  █▄█▄▄▄▄▄▄▄█
"

let mapleader = "\<Space>"

" ============================== vim-plug
call plug#begin()

Plug 'joshdick/onedark.vim' " color scheme

Plug 'tpope/vim-sleuth' " intendations

Plug 'jiangmiao/auto-pairs' " pair completion

Plug 'airblade/vim-gitgutter' " git

Plug 'itchyny/lightline.vim' " bar
Plug 'ryanoasis/vim-devicons' " icons in bar

if executable("fzf")
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
endif

if has ("nvim")
    Plug 'neovim/nvim-lspconfig' " lsp
    Plug 'Shougo/neosnippet.vim' " snippet support
    Plug 'Shougo/neosnippet-snippets' " actual snippets
    Plug 'nvim-lua/completion-nvim' " autocomplete
    Plug 'liuchengxu/vista.vim' " tags
endif

call plug#end()

" ============================== Colors
syntax on
set background=dark
colorscheme onedark
hi Normal ctermbg=NONE guibg=NONE
set termguicolors

" ============================== General
filetype indent plugin on
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
set mouse=a " a=on, c=off
set undolevels=1337
set backspace=indent,eol,start
set wildmenu " autocomplete :e
set scrolloff=10 " min lines above or below the cursor

" ============================== Statusline
set laststatus=2

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction

function! FileNameWithIcon() abort
  return winwidth(0) > 70  ?  WebDevIconsGetFileTypeSymbol() . ' ' . expand('%:t') : ''
endfunction

let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }

let g:lightline.component_function = { 'gitstatus': 'GitStatus' }
let g:lightline.component = { 'filename_with_icon': '%{FileNameWithIcon()}' }

let g:lightline.active = {
      \ 'left': [['mode', 'readonly'], ['filename_with_icon', 'modified'], ['gitstatus']],
      \ 'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
      \ }

let g:lightline.subseparator = { 'left': '|', 'right': '|' }

" ============================== Indents and Whitespaces
set list
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
"set listchars=tab:\┊\ ,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars+=vert:\  "draw verticle split

autocmd FileType perl set tabstop=8 shiftwidth=4 softtabstop=4

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

" fzf
nmap <leader>ff :Files<CR>
nmap <leader>ft :tabe<CR>:Files<CR>

" vista tags
nmap <leader>v :Vista finder fzf:vim_lsp<CR>

" ============================== Cool NeoVim Shit
if has ("nvim")
    " setup lsp configs
    lua require'marc.lsp'

    lua require'marc.completion'
endif
