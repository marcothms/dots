-- TODO: Migrate this to https://github.com/neovim/neovim/pull/12378 once merged
vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")

-- Use <Tab> and <S-Tab> to navigate through popup menu
vim.api.nvim_set_keymap("i", "<expr><Tab>", "pumvisible() ? \"\\<C-n>\" : \"\\<Tab>\"", { noremap = true })
vim.api.nvim_set_keymap("i", "<expr><S-Tab>", "pumvisible() ? \"\\<C-p>\" : \"\\<S-Tab>\"", { noremap = true })

vim.api.nvim_set_option("completeopt", "menuone,noinsert,noselect")

-- Default + c to avoid showing extra messages when using completion
vim.api.nvim_set_option("shortmess", "filnxtToOFc")

-- Trigger instantly
vim.api.nvim_set_var("completion_trigger_keyword_length", 1)

-- Ignore case for matching
vim.api.nvim_set_var("completion_matching_ignore_case", 1)

-- Also trigger completion on delete
vim.api.nvim_set_var("completion_trigger_on_delete", 1)

-- Use Neosnippet as snippet provider
vim.api.nvim_set_var("completion_enable_snippet", 'Neosnippet')

-- Neosnippet expansion bindings
vim.api.nvim_set_keymap("i", "<C-k>", "<Plug>(neosnippet_expand_or_jump)", {})
vim.api.nvim_set_keymap("s", "<C-k>", "<Plug>(neosnippet_expand_or_jump)", {})
vim.api.nvim_set_keymap("x", "<C-k>", "<Plug>(neosnippet_expand_target)", {})

-- Always do smart case matching
vim.api.nvim_set_var("g:completion_matching_smart_case", 1)

vim.api.nvim_set_var("completion_chain_complete_list", {
    default = {
        default = {
            {complete_items= {'lsp','snippet','path'}},
            {mode= '<c-p>'},
            {mode= '<c-n>'}},
        }
    }
)

-- Limit the amount of completion suggestions to 10
vim.api.nvim_set_option("pumheight", 10)
