-- Need to disable LazyVim default keymaps

return {
  "folke/todo-comments.nvim",
  opts = {
    highlight = {
      pattern = [[.*<(KEYWORDS)\s*]],
      keyword = "bg", -- Do not highlight whitespace left and right of comment keyword
    },
    search = {
      pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  },
}
