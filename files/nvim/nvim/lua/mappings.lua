local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

-- Telescope
local telescope = require'telescope'
local actions = require "telescope.actions"
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      }
    }
  }
})
map("n", "<C-f>", "<cmd> Telescope find_files<CR>", default_opts)
map("n", "<C-g>", "<cmd> Telescope live_grep<CR>", default_opts)
map("n", "<C-k>", "<cmd> Telescope keymaps<CR>", default_opts)

-- Telescope + LSP
map("n", "<leader>ls", "<cmd> Telescope lsp_workspace_symbols<CR>", default_opts)
map("n", "<leader>ld", "<cmd> Telescope lsp_definitions<CR>", default_opts)
map("n", "<leader>lr", "<cmd> Telescope lsp_references<CR>", default_opts)
map("n", "<leader>le", "<cmd> TroubleToggle<CR>", default_opts)
map("n", "<leader>la", "<cmd> lua vim.lsp.buf.code_action<CR>", default_opts)

-- Telescope + git(1)
map("n", "<leader>gs", "<cmd> Telescope git_status<CR>", default_opts)

-- cmp
local cmp = require'cmp'
cmp.setup({
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
     },
  }
)
