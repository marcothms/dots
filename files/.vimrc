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

Plug 'joshdick/onedark.vim' " Colorscheme

Plug 'tpope/vim-sleuth' " Automatic intendations

Plug 'jiangmiao/auto-pairs' " Pair completion

Plug 'airblade/vim-gitgutter' " Show git changes

Plug 'vim-airline/vim-airline' " Fancy Bar
Plug 'vim-airline/vim-airline-themes' " Themes for fancy Bar

if executable("cargo")
    Plug 'wfxr/minimap.vim', {'do': ':!cargo install --locked code-minimap'} " Fancy Side Minimap
endif

if executable("fzf")
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
endif

if has ("nvim")
    Plug 'neovim/nvim-lspconfig' " LSP
    Plug 'Shougo/neosnippet.vim' " Snippet support
    Plug 'Shougo/neosnippet-snippets' " Actual snippets
    Plug 'nvim-lua/completion-nvim' " Fancy autocomplete
endif

call plug#end()

" ============================== Colors
syntax on
set background=dark
colorscheme onedark
hi Normal ctermbg=NONE guibg=NONE
set termguicolors
filetype indent plugin on

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
set mouse=a " a=on, c=off
set undolevels=1337
set backspace=indent,eol,start
set wildmenu " autocomplete :e
set scrolloff=7 " min lines aboive or below the cursor

" ============================== Statusline
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

set laststatus=0
set statusline=

hi User1 guibg=NONE

" Left Side
set statusline +=%1*%F   " full path
set statusline +=%1*\ %m " modified flag

" Right Side
set statusline +=%1*%=%y " file type
set statusline +=%1*\ %c " column
set statusline +=%1*%5l  " current line
set statusline +=%1*/%L  " total lines

" ============================== Minimap Settings
let g:minimap_auto_start=1
let g:minimap_width=6

" ============================== Indents and Whitespaces
set list
"set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set listchars=tab:\┊\ ,extends:›,precedes:‹,nbsp:·,trail:·
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
nmap <C-f> :Files<CR>

" ============================== LSP

" ++++++++++ completion-nvim Settings
if has ("nvim")
    " Use completion-nvim in every buffer
    autocmd BufEnter * lua require'completion'.on_attach()

    " Use <Tab> and <S-Tab> to navigate through popup menu
    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

    " Set completeopt to have a better completion experience
    set completeopt=menuone,noinsert,noselect

    " Avoid showing message extra message when using completion
    set shortmess+=c

    let g:completion_trigger_keyword_length = 1
    let g:completion_matching_ignore_case = 1
    let g:completion_trigger_on_delete = 1

    let g:completion_enable_snippet = 'Neosnippet'

    let g:completion_chain_complete_list = {
    \ 'default' : {
    \   'default': [
    \       {'complete_items': ['lsp', 'snippet', 'path']},
    \       {'mode': '<c-p>'},
    \       {'mode': '<c-n>'}],
    \   }
    \}

    set pumheight=10
endif

" ++++++++++ lsp Settings
if has ("nvim")
    " Show definition
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    " Go to references
    nnoremap <silent> gr  <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> K   <cmd>lua vim.lsp.buf.hover()<CR>
endif

" ++++++++++ neosnippet Settings
if has ("nvim")
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
endif

" ++++++++++ Enable Language Servers
if has ("nvim")
    lua <<EOF
    require'nvim_lsp'.pyls.setup{}
    require'nvim_lsp'.rust_analyzer.setup{}
    require'nvim_lsp'.texlab.setup{}
    require'nvim_lsp'.jdtls.setup{}
EOF
endif
