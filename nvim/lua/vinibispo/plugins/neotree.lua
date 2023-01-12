return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    opts = {
      enable_diagnostics = true,
      enable_git_status = true,
      filesystem = {
        hijack_netrw_behavior = "open_default",
        follow_current_file = true,
        use_libuv_file_watcher = true,
      },
    },
    keys = {
      {
        "<leader>t",
        function()
          local neotree = require("neo-tree")
          neotree.focus("filesystem", true, true)
        end,
        desc = "Open Neo[T]ree",
        silent = true,
      },
    },
  }, -- File explorer
}
