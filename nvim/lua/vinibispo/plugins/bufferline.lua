return {
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = { "nvim-tree/nvim-web-devicons", { "catppuccin/nvim", name = "catppuccin", priority = 1000 } },
    config = function()
      return require("bufferline").setup({
        options = { theme = "auto", globalstatus = true, diagnostics = "nvim_lsp" },
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      })
    end,
  }, -- Bufferline (Tabs)
}
