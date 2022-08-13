local fun = require("fun")
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

  fun.each(function(value)
    vim.keymap.set(table.unpack(value))
  end, mappings)
end

setup()
set_mappings()
