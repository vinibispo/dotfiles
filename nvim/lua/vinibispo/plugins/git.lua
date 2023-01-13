return {
  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    keys = {
      {
        "<leader>gc",
        function()
          require("neogit").open({ "commit" })
        end,
        desc = "Neo[G]it [C]ommit",
      },
      {
        "<leader>gp",
        function()
          require("neogit").open({ "push" })
        end,
        desc = "Neo[G]it [P]ush",
      },
      {
        "<leader>gs",
        function()
          require("neogit").open()
        end,
        desc = "Neo[G]it [S]taging Area",
      },
    },
    cmd = "Neogit",
    opts = {
      integrations = {
        diffview = true,
      },
    },
  }, -- Git general,
}
