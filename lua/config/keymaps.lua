-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Remap Ctrl + U to redo
vim.keymap.set("n", "U", "<C-r>")

-- Deindent in insert mode with Shift + Tab
vim.keymap.set("i", "<S-Tab>", "<C-d>")
