return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    opts = {
      -- for example, context is off by default, use this to turn it on
      show_current_context = true,
      show_current_context_start = true,
    },
  }, -- Indent marks
}
