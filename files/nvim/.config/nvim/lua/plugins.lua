vim.cmd [[packadd packer.nvim]]

-- TODO: null-ls (Formatting)
-- TODO: TODO Marking
-- TODO: Latex stuff (synctex, bibtex)

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- Theme
  use({
    'sainnhe/everforest',
    config = function()
      vim.cmd("set background=light")
      vim.cmd("let g:everforest_background = 'hard'")
      vim.cmd("colorscheme everforest")
      vim.cmd("set termguicolors")
    end,
  })

  -- LuaLine
  use({
    "nvim-lualine/lualine.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require('lualine').setup({ options = { theme = 'everforest' } })
    end,
  })

  -- Fuzzy Finder (Files etc)
  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  -- Auto Indentation
  use({
    'nmac427/guess-indent.nvim',
    config = function() require('guess-indent').setup {} end,
  })

  -- Autopairs
  use({
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup({})
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = { "c", "rust", "lua", "python", "haskell" },
        auto_intall = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  })

  -- LSP
  use("neovim/nvim-lspconfig")
  use("williamboman/nvim-lsp-installer")
  use("simrat39/rust-tools.nvim") -- Cooler LSP stuff for Rust
  use {
    "folke/trouble.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      "folke/lsp-colors.nvim",
    },
    config = function() require("trouble").setup {} end,
}

  -- Snippets
  -- TODO: texlab doenst show snippets? (happy snippets)
  -- TODO: add friendly snippets
  -- https://github.com/deniserdogan/dotfiles/blob/master/lua/dannzi.lua
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
--      	snippet = {
--	        	expand = function(args)
--			       require("luasnip").lsp_expand(args.body)
--		        end,
--      	},
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'buffer' },
        },
        formatting = {
          format = function(_, vim_item)
            local icons = require("icons").lspkind
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
            return vim_item
          end,
        },
      })
    end,
  })

  -- which-key
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup { }
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
