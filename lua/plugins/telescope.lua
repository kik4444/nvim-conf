return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fb", false }, -- Disable default search in buffer
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[/] Fuzzily search in current buffer" },
    },
  },
}
