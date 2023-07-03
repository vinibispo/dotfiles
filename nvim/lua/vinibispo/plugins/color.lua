return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      "*",
      css = { hsl_fn = true },
      scss = { hsl_fn = true },
    },
  }, --Colors
}
