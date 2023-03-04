-- NOTE: Required plugins are maintained here.

-- NOTE: Plugin configuration: ${plugin}-conf.lua

-- NOTE: Use `checkhealth` after new installation

-- NOTE: Mention all dependencies in 'requires', but create their own entry,
--       if they need configuration.

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
  use({
    'kyazdani42/nvim-web-devicons',
    config = function() require 'nvim-web-devicons'.setup({ default = true }) end,
  })

  -- LuaLine
  use({
    'nvim-lualine/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons', -- All icons in bar
    },
    config = function() require('plugins.lualine-conf') end,
  })

  -- Fuzzy Finder (Files etc)
  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim', -- General functions
      'nvim-telescope/telescope-symbols.nvim', -- Search for icons
    },
    config = function() require('plugins.telescope-conf') end,
  })

  -- Auto Indentation
  use({
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  })

  -- Autopairs
  use({
    'windwp/nvim-autopairs',
    config = function() require('nvim-autopairs').setup({}) end,
  })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'kyazdani42/nvim-web-devicons',
    },
    config = function() require('plugins.nvim-treesitter-conf') end,
  })

  -- LSP
  use({
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'simrat39/rust-tools.nvim',
    },
    config = function() require('plugins.nvim-lspconfig-conf') end,
  })

  -- Suggestion window + snippets
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      'L3MON4D3/LuaSnip', -- Snippet engine
      'hrsh7th/cmp-buffer', -- Source: buffer
      'hrsh7th/cmp-nvim-lsp', -- Source: LSP symbols
      'hrsh7th/cmp-path', -- Source: path
      'rafamadriz/friendly-snippets', -- Source: JSON style snippets for LuaSnip
      'saadparwaiz1/cmp_luasnip', -- Make LuaSnip work with cmp
    },
    config = function() require('plugins.nvim-cmp-conf') end,
  })

  -- which-key
  use {
    'folke/which-key.nvim',
    config = function() require('plugins.which-key-conf') end
  }

  -- Align with `:Align <regex>`
  use 'RRethy/nvim-align'

  -- Easily comment out stuff
  use({
    'numToStr/Comment.nvim',
    config = function() require('Comment').setup() end,
  })

  -- Highlight TODOs
  use {
    'folke/todo-comments.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function() require('todo-comments').setup {} end,
  }

  -- interactive git
  use({ 'kdheepak/lazygit.nvim' })

  -- git command wrapper
  use({ 'tpope/vim-fugitive' })

  -- git signs at left side (+ blame line)
  use({
    'lewis6991/gitsigns.nvim',
    config = function() require('gitsigns').setup() end,
  })

  -- show color codes inline
  use({
    'norcalli/nvim-colorizer.lua',
    config = function() require 'colorizer'.setup() end,
  })

  -- fancy lsp loading animation
  use({
    'j-hui/fidget.nvim',
    config = function() require 'fidget'.setup {} end,
  })

  -- latex synctex (requires`pip install pygobject dbus-python pynvim`)
  use({ 'peterbjorgensen/sved' })

  -- d2-lang support (https://d2lang.com/tour/intro/)
  use({'terrastruct/d2-vim'})

  -- tree sidebar
  use({
    'nvim-tree/nvim-tree.lua',
    config = function() require('nvim-tree').setup() end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
