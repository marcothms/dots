local map = vim.api.nvim_set_keymap
local wk = require 'which-key'
local default_opts = { noremap = true, silent = true }

vim.g.mapleader = ' '

-- map("n", "<C-_>", "<cmd> noh<CR>", default_opts)
map("n", "<C-m>", "<cmd> messages<CR>", default_opts)

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
map("n", "<C-p>", "<cmd> Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>", default_opts)
map("n", "<C-f>", "<cmd> Telescope live_grep previewer=false<CR>", default_opts)
map("n", "<C-k>", "<cmd> Telescope keymaps<CR>", default_opts)

-- LSP
map("n", "<leader>la", "<cmd> lua vim.lsp.buf.code_action()<CR>", default_opts)
map("n", "<leader>ld", "<cmd> Telescope lsp_definitions<CR>", default_opts)
map("n", "<leader>le", "<cmd> Telescope diagnostics previewer=false<CR>", default_opts)
map("n", "<leader>lf", "<cmd> lua vim.lsp.buf.format {async = true }<CR>", default_opts)
map("n", "<leader>lh", "<cmd> lua vim.lsp.buf.hover()<CR>", default_opts)
map("i", "<C-h>", "<cmd> lua vim.lsp.buf.signature_help()<CR>", default_opts)
map("n", "<C-h>", "<cmd> lua vim.lsp.buf.signature_help()<CR>", default_opts)
map("n", "<leader>ln", "<cmd> lua vim.lsp.buf.rename()<CR>", default_opts)
map("n", "<leader>lr", "<cmd> Telescope lsp_references<CR>", default_opts)
map("n", "<leader>ls", "<cmd> Telescope lsp_workspace_symbols<CR>", default_opts)
map("n", "<leader>lt", "<cmd> TodoTelescope previewer=false<CR>", default_opts)
map("n", "<leader>lp", "<cmd> call SVED_Sync()<CR>", default_opts)
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

-- git(1)
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

-- telescope-symbols
map("n", "<leader>ie", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'emoji', 'gitmoji' } }<CR>", default_opts)
map("n", "<leader>im", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'julia' } }<CR>", default_opts)
map("n", "<leader>in", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'nerd' } }<CR>", default_opts)
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
    line = '<C-_>',
  }
})

-- cmp
local cmp = require 'cmp'
cmp.setup({
  mapping = {
    ["<C-n>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<Tab>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
})

-- nvim-tree
map("n", "<leader>tt", "<cmd> NvimTreeToggle<CR>", default_opts)
map("n", "<leader>tc", "<cmd> NvimTreeCollapse<CR>", default_opts)
map("n", "<leader>tr", "<cmd> NvimTreeRefresh<CR>", default_opts)
