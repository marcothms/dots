local map = vim.api.nvim_set_keymap
local wk = require 'which-key'
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
map("n", "<leader>le", "<cmd> Telescope diagnostics<CR>", default_opts)           -- Show errors and warnings
map("n", "<leader>lf", "<cmd> lua vim.lsp.buf.formatting()<CR>", default_opts)    -- Format buffer with LSP
map("n", "<leader>lh", "<cmd> lua vim.lsp.buf.hover()<CR>", default_opts)         -- Show info of symbol (double tap to enter)
map("n", "<leader>ln", "<cmd> lua vim.lsp.buf.rename()<CR>", default_opts)        -- Rename LSP symbol
map("n", "<leader>lr", "<cmd> Telescope lsp_references<CR>", default_opts)        -- Show all LSP references
map("n", "<leader>ls", "<cmd> Telescope lsp_workspace_symbols<CR>", default_opts) -- Search for LSP symbols
map("n", "<leader>lt", "<cmd> TodoTelescope<CR>", default_opts)                   -- Search for LSP symbols
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
map("n", "<leader>gs", "<cmd> Neogit<CR>", default_opts)
wk.register({
  ["<leader>"] = {
    g = {
      s = { "Status" },
    }
  }
})

-- Telescope + telescope-symbols
map("n", "<leader>ie", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'emoji', 'gitmoji' } }<CR>", default_opts) -- Show emojis
map("n", "<leader>im", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'julia' } }<CR>", default_opts)            -- Show math symbols
map("n", "<leader>in", "<cmd> lua require'telescope.builtin'.symbols{ sources = { 'nerd' } }<CR>", default_opts)             -- Show nerd icons
wk.register({
  ["<leader>"] = {
    i = {
      e = { "Emoji" },
      m = { "Math symbol" },
      n = { "Nerd Font" },
    }
  }
})

-- cmp
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback) -- Advance to next parameter
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback) -- Got back to last parameter
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-l>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  },
})

