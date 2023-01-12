return {
  {
    "TimUntersberger/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    keys = {
      {
        "n",
        "<leader>gc",
        function()
          require("neogit").open({ "commit" })
        end,
        desc = "Neo[G]it [C]ommit",
      },
      {
        "n",
        "<leader>gp",
        function()
          require("neogit").open({ "push" })
        end,
        desc = "Neo[G]it [P]ush",
      },
      {
        "n",
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
