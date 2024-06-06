return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      { "<leader>fb", false }, -- Disable default search in buffer
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[/] Fuzzily search in current buffer" },
    },
    opts = {
      defaults = {
        wrap_results = true,
        layout_config = {
          width = 0.99,
          height = 0.95,
          preview_width = 0.65,
        },
      },
    },
  },
}
