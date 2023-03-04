-- NOTE: Make sure to update packer with `:PackerInstall` and `:PackerSync`

-- NOTE: Update Treesitter with `:TSUpdate` after every nvim update

-- NOTE: Install LSP with `:LSPInstall`, log with `:LSPInfo`

-- NOTE: Rollback possible with packer.nvim:
--       Always create a snapshot BEFORE upgrading `:PackerSnapshot YEAR-MONTH-DAY`
--       Location: ~/.cache/nvim/packer.nvim

-- This must be loaded first
vim.cmd("set termguicolors")

require 'plugins'  -- Load plugins and their conf
require 'settings' -- General settings
require 'mappings' -- Keyboard mappings
