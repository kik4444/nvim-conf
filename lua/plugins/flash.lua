return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "s", mode = { "n", "x", "o" }, false }, -- mini.surround uses keybinds starting with "s"
  },
  opts = {
    jump = {
      autojump = true,
    },
    label = {
      rainbow = {
        enabled = true,
      },
    },
    modes = {
      search = {
        enabled = true,
      },
      char = {
        jump_labels = true,
      },
    },
  },
}
