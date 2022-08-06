-- Custom warning symbols
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Easily install LSPs with `:LSPInstall`
require("nvim-lsp-installer").setup({
  automatic_installation = true,
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗",
    },
  },
})

local lsp = require('lspconfig')
local navic = require('nvim-navic') -- breadcrumbs

-- Normal LSPs
-- Install with `:LSPInstall`
local servers = { "pylsp", "sumneko_lua", "hls", "clangd" }
for _, i in ipairs(servers) do
  lsp[i].setup({
    on_attach = function(client, bufnr)
      navic.attach(client, bufnr) -- breadcrumbs
    end
  })
end

-- LaTeX (build with `:TexlabBuild`)
-- Extra config for autocompile
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/texlab.lua
lsp.texlab.setup({
  on_attach = function(client, bufnr)
    navic.attach(client, bufnr) -- breadcrumbs
  end,
  settings = {
    texlab = {
      build = {
        args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '-shell-escape', '%f' },
        onSave = true,
      }
    }
  }
})

-- Rust (use rust-tools to setup lsp, because it has more features)
local opts = {
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  server = { -- these settings go directly to lsp
    on_attach = function(client, bufnr)
      navic.attach(client, bufnr) -- breadcrumbs
    end,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy"
        },
      }
    }
  },
}

require('rust-tools').setup(opts)
