-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.scrolloff = 5 -- Minimal number of screen lines to keep above and below the cursor.

vim.opt.shell = "nu"

vim.opt.shiftwidth = 4 -- Size of an indent
vim.opt.tabstop = 4 -- Number of spaces tabs count for

vim.filetype.add({
  pattern = {
    [".*/hypr/.*%.conf"] = "hyprlang",
    [".*/kitty/.*%.conf"] = "bash",
  },
  extension = {
    nu = "nu",
    job = "yaml", -- Used in palerts
    rasi = "rasi",
    alloy = "hcl",
  },
  filename = {
    ["flake.lock"] = "json",
    Jenkinsfile = "groovy",
    ["go.mod"] = "gomod", -- Sometimes gopls needs help
  },
})
