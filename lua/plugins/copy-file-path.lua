return {
  "mogulla3/copy-file-path.nvim",
  keys = {
    "<leader>p",
    { mode = { "n" }, "<leader>pr", vim.cmd.CopyRelativeFilePath, desc = "Copy [R]elative Path" },
    { mode = { "n" }, "<leader>pf", vim.cmd.CopyFileName, desc = "Copy [F]ile Name" },
    { mode = { "n" }, "<leader>pa", vim.cmd.CopyAbsoluteFilePath, desc = "Copy [A]bsolute File Path" },
  },
}
