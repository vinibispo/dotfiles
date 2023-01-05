local function config()
  local neogit = require("neogit")
  local function setup()
    neogit.setup({
      kind = "split",
      integrations = { diffview = true },
    })
  end

  local function set_mappings()
    local opts = { noremap = true, silent = true }
    local mappings = {
      {
        "n",
        "<leader>gc",
        function()
          neogit.open({ "commit" })
        end,
        opts,
      },
      {
        "n",
        "<leader>gp",
        function()
          neogit.open({ "push" })
        end,
        opts,
      },
      { "n", "<leader>gs", neogit.open, opts },
    }

    for _, mapping in pairs(mappings) do
      vim.keymap.set(unpack(mapping))
    end
  end

  setup()
  set_mappings()
end

return {
  {
    dir = "~/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    keys = "<leader>gs",
    cmd = "Neogit",
    config = config,
  }, -- Git general,
}
