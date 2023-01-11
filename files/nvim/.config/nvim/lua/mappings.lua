local map = vim.api.nvim_set_keymap
local wk = require 'which-key'
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

map("n", "<C-_>", "<cmd> noh<CR>", default_opts)
map("n", "<C-n>", "<cmd> messages<CR>", default_opts)

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
map("n", "<C-f>", "<cmd> Telescope find_files hidden=true<CR>", default_opts) -- Show files
map("n", "<C-s>", "<cmd> Telescope live_grep<CR>", default_opts) -- Grep through current directory
map("n", "<C-k>", "<cmd> Telescope keymaps<CR>", default_opts) -- Show all keys

-- Telescope + LSP
map("n", "<leader>la", "<cmd> lua vim.lsp.buf.code_action()<CR>", default_opts) -- Apply LSP code action
map("n", "<leader>ld", "<cmd> Telescope lsp_definitions<CR>", default_opts) -- Show all LSP definitions (or jump if only 1)
map("n", "<leader>le", "<cmd> Telescope diagnostics<CR>", default_opts) -- Show errors and warnings
map("n", "<leader>lf", "<cmd> lua vim.lsp.buf.format {async = true }<CR>", default_opts) -- Format buffer with LSP
map("n", "<leader>lh", "<cmd> lua vim.lsp.buf.hover()<CR>", default_opts) -- Show info of symbol (double tap to enter)
map("n", "<leader>ln", "<cmd> lua vim.lsp.buf.rename()<CR>", default_opts) -- Rename LSP symbol
map("n", "<leader>lr", "<cmd> Telescope lsp_references<CR>", default_opts) -- Show all LSP references
map("n", "<leader>ls", "<cmd> Telescope lsp_workspace_symbols<CR>", default_opts) -- Search for LSP symbols
map("n", "<leader>lt", "<cmd> TodoTelescope<CR>", default_opts) -- Show all TODOs in a project
map("n", "<leader>lp", "<cmd> call SVED_Sync()<CR>", default_opts) -- synctex
wk.register({
  ["<leader>"] = {
    l = {
      a = { "Actions" },
      d = { "Definitions" },
      e = { "Errors" },
      f = { "Format buffer" },
      h = { "Hover information" },
      n = { "(Re)Name symbol" },
      r = { "References" },
      s = { "Symbols" },
      t = { "TODOs" },
    }
  }
})

-- git
map("n", "<leader>gb", "<cmd> Git blame<CR>", default_opts)
map("n", "<leader>gl", "<cmd> LazyGitFilter<CR>", default_opts)
map("n", "<leader>gf", "<cmd> LazyGitFilterCurrentFile<CR>", default_opts)
map("n", "<leader>gs", "<cmd> LazyGit<CR>", default_opts)
wk.register({
  ["<leader>"] = {
    g = {
      b = { "Blame" },
      l = { "Log" },
      f = { "(Log Current) File" },
      s = { "Status" },
    }
  }
})

-- Telescope + telescope-symbols
map("n", "<leader>ie", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'emoji', 'gitmoji' } }<CR>",
  default_opts) -- Show emojis
map("n", "<leader>im", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'julia' } }<CR>", default_opts) -- Show math symbols
map("n", "<leader>in", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'nerd' } }<CR>", default_opts) -- Show nerd icons
wk.register({
  ["<leader>"] = {
    i = {
      e = { "Emoji" },
      m = { "Math symbol" },
      n = { "Nerd Font icon" },
    }
  }
})

-- Comment.nvim
require('Comment').setup({
  opleader = {
    line = '<leader>cl',
    block = '<leader>cb',
  }
})
wk.register({
  ["<leader>"] = {
    c = {
      l = { "Line comment" },
      b = { "Block comment" },
    }
  }
})

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

