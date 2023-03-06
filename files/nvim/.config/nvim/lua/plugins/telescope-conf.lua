require('telescope').setup({
  defaults = {
    prompt_prefix = "   ",
    selection_caret = "  ",
    entry_prefix = "  ",
    border = false,
    sorting_strategy = "ascending",
    layout_strategy = "bottom_pane",
    layout_config = {
      vertical = {
        width = 140,
        prompt_position = "top",
        mirror = true,
      },
      bottom_pane = {
        theme = get_ivy
      }
    }
  },
})
