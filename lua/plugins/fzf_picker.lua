return {
  "ibhagwan/fzf-lua",
  opts = function(_, opts)
    opts.winopts.width = 0.99
    opts.winopts.preview.horizontal = "right:65%"

    -- Open multiple selections in buffers instead of sending them to quickfix list.
    require("fzf-lua.config").defaults.actions.files.default = require("fzf-lua.actions").file_edit
  end,
}
