return {
  {
    "echasnovski/mini.move",
    event = "VeryLazy",
    -- Load the plugin after Lazy to override its default keybinds for moving
    config = function(_, opts)
      vim.schedule(function()
        require("mini.move").setup(opts)
      end)
    end,
  },
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "sd", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`
      },
    },
  },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    keys = {
      {
        mode = { "i" },
        "<C-/>",
        function()
          local line_number = vim.api.nvim_win_get_cursor(0)[1]
          MiniComment.toggle_lines(line_number, line_number)
        end,
        desc = "Comment line",
      },
    },
  },
}
