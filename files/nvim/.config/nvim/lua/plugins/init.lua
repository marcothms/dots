-- NOTE:
-- Define all plugins in this file,
-- but maintain config in <PLUGIN-NAME>-conf.lua

-- Mention all dependencies in 'requires', but create their own entry,
-- if they need configuration.

local fn = vim.fn

-- This should auto install packer, if it is not installed on system
-- Otherwise use:
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use({
    'sainnhe/everforest',
    config = function() require('plugins.everforest-conf') end,
  })

  -- Icons
  -- Load here, because otherwise icons won't show correctly
  use({
    "kyazdani42/nvim-web-devicons",
    config = function() require('plugins.nvim-web-devicons-conf') end,
  })

  -- LuaLine
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons", -- All icons in bar
      "arkav/lualine-lsp-progress", -- Show lsp loading progress
      "SmiteshP/nvim-navic", -- Show breadcrumbs (loaded in lualine-conf)
      "neovim/nvim-lspconfig", -- for nvim-navic (loaded later)
    },
    config = function() require('plugins.lualine-conf') end,
  })

  -- Fuzzy Finder (Files etc)
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim", -- General functions
      "nvim-telescope/telescope-symbols.nvim", -- Search for icons
    },
    config = function() require('plugins.telescope-conf') end,
  })

  -- Auto Indentation
  use({
    'nmac427/guess-indent.nvim',
    config = function() require('plugins.guess-indent-conf') end,
  })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    config = function() require('plugins.nvim-autopairs-conf') end,
  })

  -- Treesitter (Update with `:TSUpdate`)
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function() require('plugins.nvim-treesitter-conf') end,
  })

  -- LSP (install with `:LSPInstall`, inspect with `:LSPInfo`)
  use({
    "neovim/nvim-lspconfig", -- Easier to manage LSP servers
    requires = {
      "williamboman/nvim-lsp-installer", -- Easy to install LSP servers
      "simrat39/rust-tools.nvim" -- Cooler LSP stuff for Rust
    },
    config = function() require('plugins.nvim-lspconfig-conf') end,
  })

  -- Snippets
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      "L3MON4D3/LuaSnip", -- Snippet engine
      "hrsh7th/cmp-buffer", -- Source: buffer
      "hrsh7th/cmp-nvim-lsp", -- Source: LSP symbols
      "hrsh7th/cmp-path", -- Source: path
      "rafamadriz/friendly-snippets", -- Source: JSON style snippets for LuaSnip
      "saadparwaiz1/cmp_luasnip", -- Make LuaSnip work with cmp
    },
    config = function() require('plugins.nvim-cmp-conf') end,
  })

  -- which-key (Show key combos)
  use {
    "folke/which-key.nvim",
    config = function() require('plugins.which-key-conf') end
  }

  -- Align with `:Align <regex>`
  use 'RRethy/nvim-align'

  -- Easily comment out stuff
  use({
    "numToStr/Comment.nvim",
    config = function() require('plugins.Comment-conf') end,
  })

  -- Highlight TODOs
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require('plugins.todo-comments-conf') end
  }

  -- git client
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim', -- General functions
    config = function() require('plugins.neogit-conf') end,
  }

  use 'tpope/vim-fugitive'

  -- git signs at left side (+ blame line)
  use {
    'lewis6991/gitsigns.nvim',
    config = function() require('plugins.gitsigns-conf') end
  }

  -- show color codes inline
  use({
    "norcalli/nvim-colorizer.lua",
    config = function() require('plugins.nvim-colorizer-conf') end
  })

  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    config = function() require('plugins.nvim-tree-conf') end
  }

  -- cooler cmd line and notifications
  use({
    "folke/noice.nvim",
    event = "VimEnter",
    config = function()
      require("noice").setup()
    end,
    requires = {
      "MunifTanjim/nui.nvim", -- frontend for cmdline
    },
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
