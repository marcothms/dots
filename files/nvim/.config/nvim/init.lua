-- Make sure to update packer with `:PackerInstall` and `:PackerSync`
-- Treesitter with `:TSUpdate`
-- LSP with `:LSPInstall`, log with `:LSPInfo`

-- This must be loaded first
vim.cmd("set termguicolors")

require 'plugins'  -- Load plugins
require 'settings' -- General settings
require 'mappings' -- Keyboard mappings
require 'lsp'      -- Everything related to LSP
