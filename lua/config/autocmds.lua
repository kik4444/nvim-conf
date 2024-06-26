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
  pattern = { "*.json", "*.jsonc", "*.pp", "*.alloy" },
  callback = function()
    vim.opt.shiftwidth = 2
  end,
})

-- "#" comments
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("# comments", { clear = true }),
  pattern = { "hyprlang", "puppet" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
})

-- "//" comments
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("// comments", { clear = true }),
  pattern = { "jsonc", "proto" },
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "// %s"
  end,
})
