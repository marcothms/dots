vim.cmd [[packadd packer.nvim]]

local fn = vim.fn
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
    config = function()
      vim.cmd("set background=light")
      vim.cmd("let g:everforest_background = 'hard'")
      vim.cmd("colorscheme everforest")
      vim.cmd("set termguicolors")
    end,
  })

  -- Breadcrumbs (will be loaded into LuaLine)
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig",
    config = function()
      require 'nvim-navic'.setup({})
    end,
  }

  -- Icons
  use({
    "kyazdani42/nvim-web-devicons",
    config = function()
      require 'nvim-web-devicons'.setup({
        default = true
      })
    end,
  })

  -- LuaLine
  use({
    "nvim-lualine/lualine.nvim",
    requires = {
      "kyazdani42/nvim-web-devicons",
      "arkav/lualine-lsp-progress", -- Show lsp loading progress
      "SmiteshP/nvim-navic", -- Show breadcrumbs
    },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'everforest'
        },
        sections = {
          lualine_b = {
            'branch',
            'diff',
            {
              'diagnostics',
              diagnostics_color = {
                warn = { fg = "orange" },
                info = { fg = "#479bc7" },
                hint = { fg = "darkcyan" }
              },
            }

          },
          lualine_c = { 'filename', require('nvim-navic').get_location },
          lualine_x = { 'lsp_progress', 'encoding', 'fileformat', 'filetype' },
          lualine_z = {
            'location',
            function()
              -- Show trailing whitespace
              local space = vim.fn.search([[\s\+$]], 'nwc')
              return space ~= 0 and "TW:" .. space or ""
            end
          }
        }
      })
    end,
  })

  -- Fuzzy Finder (Files etc)
  use({
    "nvim-telescope/telescope.nvim",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-symbols.nvim", -- Search for icons
    },
    config = function()
      require('telescope').setup({
        defaults = {
          prompt_prefix = "   ",
          selection_caret = "  ",
          entry_prefix = "  ",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = {
              prompt_position = "top",
            }
          }
        },
      })
    end,
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

  -- Treesitter (Update with `:TSUpdate`)
  use({
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          "bash",
          "c",
          "haskell",
          "json",
          "latex",
          "lua",
          "python",
          "rust",
        },
        auto_intall = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      })
    end,
  })

  -- LSP (install with `:LSPInstall`, inspect with `:LSPInfo`)
  use("neovim/nvim-lspconfig") -- Easy to manage LSP servers (attach etc)
  use("williamboman/nvim-lsp-installer") -- Easy to install LSP servers
  use("simrat39/rust-tools.nvim") -- Cooler LSP stuff for Rust

  -- Snippets
  -- TODO: max candidates
  -- TODO: time trigger activation
  use({
    'hrsh7th/nvim-cmp',
    requires = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require 'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
        formatting = {
          -- Show icons in cmp box
          format = function(_, vim_item)
            local icons = require("icons").lspkind
            vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
            return vim_item
          end,
        },
      })
      -- Load in friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()
      -- TODO: Add own snippets
      --[[ require("luasnip.loaders.from_vscode").lazy_load({
        paths = {
          "~/.config/nvim/snippets",
          "/home/marc/.local/share/nvim/site/pack/packer/start/friendly-snippets"
        }
      }) ]]
    end,
  })

  -- which-key
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }

  -- Align with `:Align <regex>`
  use 'RRethy/nvim-align'

  -- Easily comment out stuff (gc, gb)
  use({
    "numToStr/Comment.nvim",
    config = function()
      require('Comment').setup({})
    end,
  })

  -- Highlight TODOs
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {}
    end
  }

  -- git client
   use {
     'TimUntersberger/neogit',
     requires = 'nvim-lua/plenary.nvim',
     config = function()
      local neogit = require('neogit')
      neogit.setup {
        signs = {
          section = { "﬌", "" },
          item = { "﬌", "" },
        }
      }
     end,
   }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
