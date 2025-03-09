return {
  "folke/ts-comments.nvim",
  opts = {
    lang = {
      hyprlang = "# %s",
      puppet = "# %s",
      jsonc = "// %s",
      proto = "// %s",
      gomod = "// %s",
      hcl = { "// %s", "# %s" }, -- If we treat River as hcl, then // should be first because hcl supports both
      nu = "# %s",
    },
  },
}
