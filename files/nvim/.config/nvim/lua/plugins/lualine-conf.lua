-- startup breadcrumbs
require 'nvim-navic'.setup({})

-- used as mode-module
-- https://github.com/nvim-lualine/lualine.nvim/issues/614
local mode_map = {
  ['n']    = '',
  ['no']   = 'O-P',
  ['nov']  = 'O-P',
  ['noV']  = 'O-P',
  ['no'] = 'O-P',
  ['niI']  = '',
  ['niR']  = '',
  ['niV']  = '',
  ['nt']   = '',
  ['v']    = '',
  ['vs']   = '',
  ['V']    = ' ',
  ['Vs']   = ' ',
  ['']   = ' ',
  ['s']  = ' ',
  ['s']    = 'S',
  ['S']    = 'SL',
  ['i']    = '',
  ['ic']   = '',
  ['ix']   = '',
  ['R']    = '菱',
  ['Rc']   = '菱',
  ['Rx']   = '菱',
  ['Rv']   = 'VR',
  ['Rvc']  = 'VR',
  ['Rvx']  = 'VR',
  ['c']    = '',
  ['cv']   = 'EX',
  ['ce']   = 'EX',
  ['r']    = 'R',
  ['rm']   = 'MORE',
  ['r?']   = 'CONFIRM',
  ['!']    = 'SH',
  ['t']    = 'T',
}

-- actually load bar
require('lualine').setup({
  options = {
    -- lualine comes with 'everforest' theme
    theme = 'everforest',
  },
  -- tabline = {
  --   lualine_a = {
  --     -- function()
  --     --   return mode_map[vim.api.nvim_get_mode().mode] or "__"
  --     -- end
  --     function()
  --       return '裡'
  --     end,
  --   },
  --   lualine_b = {
  --     {
  --       'tabs',
  --       mode = 2,
  --       max_length = vim.o.columns / 2
  --     }
  --   },
  --   lualine_c = {
  --
  --   },
  --   lualine_x = {
  --     -- 'lsp_progress' -- noice already shows this.. better
  --   },
  --   lualine_y = {
  --     require('nvim-navic').get_location
  --   },
  --   lualine_z = {
  --   }
  -- },
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
    },
    lualine_x = {
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
      'encoding',
      'fileformat',
      'filetype',
    },
    lualine_z = {
      -- show wordcount in md and tex file
      -- show precise count when selecting
      function()
        if vim.bo.filetype == "markdown" or vim.bo.filetype == "tex" then
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
      end,
      'location',
      -- Show trailing whitespace
      function()
        local space = vim.fn.search([[\s\+$]], 'nwc')
        return space ~= 0 and "TW:" .. space or ""
      end,
    },
  },
})
