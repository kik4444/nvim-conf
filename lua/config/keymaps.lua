-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remap Ctrl + U to redo
vim.keymap.set("n", "U", "<C-r>")

-- Deindent in insert mode with Shift + Tab
vim.keymap.set("i", "<S-Tab>", "<C-d>")

-- Delete marks
vim.keymap.set("n", "M", "<cmd>delmarks!<cr>", { desc = "Delete marks" })

local key = "C"
if vim.uv.os_uname().sysname == "Darwin" then
  key = "D"
end

-- Resize window using Ctrl or Cmd + arrow keys
vim.keymap.set("n", "<" .. key .. "-Up>", "<cmd>resize +5<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<" .. key .. "-Down>", "<cmd>resize -5<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<" .. key .. "-Left>", "<cmd>vertical resize -5<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<" .. key .. "-Right>", "<cmd>vertical resize +5<cr>", { desc = "Increase Window Width" })

-- lazygit
vim.keymap.set("n", "<leader>gf", function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
