local function config()
  local neotree = require("neo-tree")
  local function setup()
    neotree.setup({
      enable_diagnostics = true,
      enable_git_status = true,
      filesystem = {
        hijack_netrw_behavior = "open_default",
      },
    })
  end

  local function set_mappings()
    local opts = { silent = true, noremap = true }
    local mappings = {
      {
        "n",
        "<leader>t",
        function()
          neotree.focus("filesystem", true, true)
        end,
        opts,
      },
    }

    for _, value in ipairs(mappings) do
      vim.keymap.set(table.unpack(value))
    end
  end

  setup()
  set_mappings()
end

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = config,
  }, -- File explorer
}
