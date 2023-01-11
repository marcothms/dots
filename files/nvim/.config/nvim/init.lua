-- Make sure to update packer with `:PackerInstall` and `:PackerSync`
-- Treesitter with `:TSUpdate` after every nvim update.
-- LSP with `:LSPInstall`, log with `:LSPInfo`
--
-- Rollback possible with packer.nvim
-- Always create a snapshot BEFORE upgrading, so we can rollback if we find sth
-- `:PackerSnapshot YEAR-MONTH-DAY
-- Location: ~/.cache/nvim/packer.nvim

-- This must be loaded first
vim.cmd("set termguicolors")

require 'plugins'  -- Load plugins and their conf
require 'settings' -- General settings
require 'mappings' -- Keyboard mappings
