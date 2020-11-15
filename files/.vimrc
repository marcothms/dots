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
endif

call plug#end()

""" ============================== Colors
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

let g:lightline.separator = { 'left': "", 'right': "" }
let g:lightline.tabline_separator = { 'left': "", 'right': "" }
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
nmap <C-f> :Files<CR>

" ============================== LSP

" ---------- completion-nvim Settings
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

" ---------- lsp Settings
if has ("nvim")
    " Show definition
    nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
    " Go to references
    nnoremap <silent> gr  <cmd>lua vim.lsp.buf.references()<CR>
    nnoremap <silent> K   <cmd>lua vim.lsp.buf.hover()<CR>
endif

" ---------- neosnippet Settings
if has ("nvim")
    imap <C-k> <Plug>(neosnippet_expand_or_jump)
    smap <C-k> <Plug>(neosnippet_expand_or_jump)
    xmap <C-k> <Plug>(neosnippet_expand_target)
endif

" ---------- Enable Language Servers
if has ("nvim")
    if executable("pyls")
        lua << EOF
        require'nvim_lsp'.pyls.setup{}
EOF
    endif

    if executable("rust-analyzer")
        lua << EOF
        require'nvim_lsp'.rust_analyzer.setup{}
EOF
    endif

    if executable("texlab")
        lua << EOF
        require'nvim_lsp'.texlab.setup{}
EOF
    endif

    if isdirectory($HOME. "/.cache/nvim/nvim_lsp/jdtls")
        lua << EOF
        require'nvim_lsp'.jdtls.setup{}
EOF
    endif
endif
