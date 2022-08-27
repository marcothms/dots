require('nvim-treesitter.configs').setup({
  ensure_installed = { -- can also be manually installed with :TSInstall
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
