local opt          = vim.opt

opt.colorcolumn    = "80"      -- Colored column at 80c
opt.cursorline     = true      -- Highlight entire current row
opt.number         = true      -- Show line numbers
opt.relativenumber = true      -- Show relative line numbers from cursor
opt.scrolloff      = 12        -- Minimum lines at top and bottom
opt.signcolumn     = "yes"     -- Show icons column at on the left side
opt.swapfile       = false     -- Do not create a swapfile
opt.smartindent    = true      -- Autoindent new lines
opt.showmode       = false     -- Disable status on most bottom row
opt.clipboard      = "unnamed" -- Copy & Paste with system clipboard
opt.list           = true      -- Show trailing whitespaces

vim.opt.undofile   = true      -- Save undo history
vim.o.mouse        = 'a'       -- Enable mouse
