local keys = {}

-- Go to Buffer N with Alt + N where N is a number from 1 to 10
for i = 0, 9 do
  keys[i] = {
    mode = { "n", "i" },
    "<A-" .. i .. ">",
    function()
      if i == 0 then
        i = 10
      end
      vim.cmd.BufferLineGoToBuffer(i)
    end,
    desc = "Go to Buffer " .. i,
  }
end

-- Moving and closing buffers
for _, key in ipairs({
  { mode = { "n" }, "<leader>br", false }, -- Disable default close right buffers
  { mode = { "n" }, "<leader>bh", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Left" },
  { mode = { "n" }, "<leader>bl", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Right" },
  { mode = { "n" }, "<leader>bH", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Buffers to the Left" },
  { mode = { "n" }, "<leader>bL", "<cmd>BufferLineCloseRight<cr>", desc = "Close Buffers to the Right" },
}) do
  keys[#keys + 1] = key
end

return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = keys,
  opts = {
    options = {
      numbers = "ordinal",
      separator_style = "slant",
      always_show_bufferline = true,
    },
  },
}
