return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<leader>fe", false },
    { "<leader>fE", false },
    {
      "<leader>e",
      "<cmd>Neotree toggle reveal_force_cwd<cr>",
      desc = "Explorer Neotree (reveal)",
    },
  },
  opts = {
    default_component_configs = {
      symlink_target = {
        enabled = true,
      },
    },
    filesystem = {
      bind_to_cwd = true,
      filtered_items = {
        visible = true,
      },
      group_empty_dirs = true,
    },
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
    event_handlers = {
      {
        event = "neo_tree_buffer_enter",
        handler = function()
          vim.opt_local.number = true
          vim.opt_local.relativenumber = true
        end,
      },
    },
  },
}
