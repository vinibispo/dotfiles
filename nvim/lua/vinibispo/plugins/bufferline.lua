return {
  {
    "akinsho/bufferline.nvim",
    version = "v3.*",
    dependencies = { "nvim-tree/nvim-web-devicons", { "catppuccin/nvim", name = "catppuccin", priority = 1000 } },
    event = "BufAdd",
    config = function()
      return require("bufferline").setup({
        options = { theme = "auto", globalstatus = true, diagnostics = "nvim_lsp" },
        highlights = require("catppuccin.groups.integrations.bufferline").get(),
      })
    end,
    keys = {
      {
        "<leader>z",
        function()
          require("bufferline").cycle(-1)
        end,
        desc = "Previou[Z] Buffer",
      },
      {
        "<leader>x",
        function()
          require("bufferline").cycle(1)
        end,
        desc = "Ne[X]t Buffer",
      },
    },
  }, -- Bufferline (Tabs)
}
