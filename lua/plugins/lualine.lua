return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    for _, t in ipairs({
      { "encoding" },
      { "fileformat" },
      { "filesize" },
    }) do
      table.insert(opts.sections.lualine_x, t)
    end
  end,
}
