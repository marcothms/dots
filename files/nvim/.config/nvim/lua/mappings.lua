local map = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

map("n", "<C-_>", "<cmd> noh<CR>", default_opts)

-- Telescope
local telescope = require 'telescope'
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
map("n", "<C-f>", "<cmd> Telescope find_files<CR>", default_opts) -- Show files
map("n", "<C-g>", "<cmd> Telescope live_grep<CR>", default_opts)  -- Grep through current directory
map("n", "<C-k>", "<cmd> Telescope keymaps<CR>", default_opts)    -- Show all keys

-- Telescope + LSP
map("n", "<leader>la", "<cmd> lua vim.lsp.buf.code_action()<CR>", default_opts)   -- Apply LSP code action
map("n", "<leader>ld", "<cmd> Telescope lsp_definitions<CR>", default_opts)       -- Show all LSP definitions (or jump if only 1)
map("n", "<leader>le", "<cmd> TroubleToggle<CR>", default_opts)                   -- Show errors and warnings
map("n", "<leader>lf", "<cmd> lua vim.lsp.buf.formatting()<CR>", default_opts)    -- Format buffer with LSP
map("n", "<leader>lh", "<cmd> lua vim.lsp.buf.hover()<CR>", default_opts)         -- Show info of symbol (double tap to enter)
map("n", "<leader>lr", "<cmd> Telescope lsp_references<CR>", default_opts)        -- Show all LSP references
map("n", "<leader>ls", "<cmd> Telescope lsp_workspace_symbols<CR>", default_opts) -- Search for LSP symbols

-- Telescope + git(1)
map("n", "<leader>gs", "<cmd> Telescope git_status<CR>", default_opts)

-- cmp
local cmp = require 'cmp'
cmp.setup({
  mapping = {
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-l>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
})
