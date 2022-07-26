local luasnip = require("luasnip")
local function setup()
  luasnip.filetype_extend("ruby", { "rails" })
  luasnip.config.setup({
    history = true,
    store_selection_keys = "<Tab>",
    updateevents = "TextChanged, TextChangedI",
    delete_check_events = "TextChanged, TextChangedI",
  })

  local from_vscode = require("luasnip.loaders.from_vscode")
  from_vscode.lazy_load()

  for _, lang in pairs({ "ruby" }) do
    luasnip.add_snippets(lang, require("snippets." .. lang), { key = lang })
  end
end

local function set_mappings()
  local opts = { silent = true, noremap = true }
  local mappings = {
    {
      { "i", "s" },
      "<C-j>",
      function()
        luasnip.jump(1)
      end,
      opts,
    },
    {
      { "i", "s" },
      "<C-i>",
      function()
        luasnip.jump(-1)
      end,
      opts,
    },
  }

  for _, value in pairs(mappings) do
    vim.keymap.set(unpack(value))
  end
end

setup()

set_mappings()
