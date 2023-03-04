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
    "vim",
    "markdown",
    "markdown_inline"
  },
  auto_intall = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
