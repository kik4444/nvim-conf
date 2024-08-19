return {
  "lewis6991/gitsigns.nvim",
  keys = {
    { mode = { "n" }, "<leader>gl", "<cmd>Gitsigns toggle_current_line_blame<cr>", desc = "Toggle current line blame" },
  },
  opts = {
    numhl = true,
    current_line_blame_opts = {
      delay = 300,
    },
  },
}
