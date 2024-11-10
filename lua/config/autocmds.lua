-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Trim trailing whitespace on each line and whitespace at end of file
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  callback = function()
    local save_cursor = vim.fn.getpos(".")

    pcall(function()
      vim.cmd([[%s/\s\+$//e]])
    end)

    pcall(function()
      vim.cmd([[%s#\($\n\s*\)\+\%$##]])
    end)

    vim.fn.setpos(".", save_cursor)
  end,
  desc = "Trim whitespace",
})

-- 2 spaces width for certain files
vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { "*.json", "*.jsonc", "*.yaml", "*.yml", "*.pp", "*.job", "*.alloy" },
  callback = function()
    vim.opt.shiftwidth = 2
  end,
  desc = "Set shiftwidth to 2 for certain files",
})
