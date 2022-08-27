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
    config = function()
      vim.cmd("set background=light")
      vim.cmd("let g:everforest_background = 'hard'")
      vim.cmd("colorscheme everforest")
    end,
  })

  -- Icons
  -- Load here, because otherwise icons won't show
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
      "neovim/nvim-lspconfig", -- for nvim-navic
    },
    config = function()
      -- startup breadcrumbs
      require 'nvim-navic'.setup({})

      -- used as mode-module
      local mode_map = {
        ['n'] = 'N',
        ['v'] = 'V',
        ['i'] = 'I',
        ['V'] = 'VL',
        [''] = "VB",
        ['s'] = "VB",
        ['c'] = "C",
      }

      -- actually load bar
      require('lualine').setup({
        options = {
          -- lualine comes with 'everforest' theme
          theme = 'everforest',
        },
        -- all sections from left to right
        sections = {
          lualine_a = {
            function()
              return mode_map[vim.api.nvim_get_mode().mode] or "__"
            end
          },
          lualine_b = {
            'branch',
          },
          lualine_c = {
            {
              'filename',
              path = 1,
            },
            require('nvim-navic').get_location
          },
          lualine_x = {
            'lsp_progress',
            {
              'diagnostics',
              diagnostics_color = {
                warn = { fg = "orange" },
                info = { fg = "#479bc7" },
                hint = { fg = "darkcyan" }
              },
            },
          },
          lualine_y = {
            'filetype',
            'encoding',
            'fileformat',
            -- show wordcount in md and tex file
            -- show precise count when selecting
            function()
              if vim.bo.filetype == "md" or vim.bo.filetype == "tex" then
                if vim.fn.wordcount().visual_words == 1 then
                  return tostring(vim.fn.wordcount().visual_words) .. " word"
                elseif not (vim.fn.wordcount().visual_words == nil) then
                  return tostring(vim.fn.wordcount().visual_words) .. " words"
                else
                  return tostring(vim.fn.wordcount().words) .. " words"
                end
              else
                return ""
              end
            end
          },
          lualine_z = {
            'progress',
            'location',
            -- Show trailing whitespace
            function()
              local space = vim.fn.search([[\s\+$]], 'nwc')
              return space ~= 0 and "TW:" .. space or ""
            end
          },
        },
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
          layout_strategy = "vertical",
          layout_config = {
            vertical = {
              prompt_position = "top",
              mirror = true,
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
          "make",
          "python",
          "rust",
          "yaml",
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
  -- Config in lsp.lua
  use("neovim/nvim-lspconfig") -- Easy to manage LSP servers (attach etc)
  use("williamboman/nvim-lsp-installer") -- Easy to install LSP servers
  use("simrat39/rust-tools.nvim") -- Cooler LSP stuff for Rust

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
    config = function()
      local cmp = require 'cmp'
      cmp.setup({
        snippet = {
          expand = function(args) -- set a snippet engine
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = {
          { name = 'luasnip', keyword_length = 1, max_item_count = 3 },
          { name = 'nvim_lsp', keyword_length = 1, max_item_count = 10 },
          { name = 'buffer', keyword_length = 5, max_item_count = 3 },
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
      -- Load friendly-snippets
      require('luasnip.loaders.from_vscode').lazy_load()
      -- Load own snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
    end,
  })

  -- which-key (Show key combos)
  use {
    "folke/which-key.nvim",
    config = function() require("which-key").setup {} end
  }

  -- Align with `:Align <regex>`
  use 'RRethy/nvim-align'

  -- Easily comment out stuff
  use({
    "numToStr/Comment.nvim",
    config = function() require('Comment').setup() end,
  })

  -- Highlight TODOs
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end
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

  -- git signs at left side (+ blame line)
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- show color codes inline
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require 'colorizer'.setup()
    end
  })

  -- file tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
