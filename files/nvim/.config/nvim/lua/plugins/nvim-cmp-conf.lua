lspkind = {
   Namespace = "",
   Text = " ",
   Method = " ",
   Function = " ",
   Constructor = " ",
   Field = "ﰠ ",
   Variable = " ",
   Class = "ﴯ ",
   Interface = " ",
   Module = " ",
   Property = "ﰠ ",
   Unit = "塞 ",
   Value = " ",
   Enum = " ",
   Keyword = " ",
   Snippet = " ",
   Color = " ",
   File = " ",
   Reference = " ",
   Folder = " ",
   EnumMember = " ",
   Constant = " ",
   Struct = "פּ ",
   Event = " ",
   Operator = " ",
   TypeParameter = " ",
   Table = "",
   Object = " ",
   Tag = "",
   Array = "[]",
   Boolean = " ",
   Number = " ",
   Null = "ﳠ",
   String = " ",
   Calendar = "",
   Watch = " ",
   Package = "",
}

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
      vim_item.kind = string.format("%s %s", lspkind[vim_item.kind], vim_item.kind)
      return vim_item
    end,
  },
})
-- Load friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()
-- Load own snippets
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
