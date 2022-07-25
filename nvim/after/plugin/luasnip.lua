local luasnip = require('luasnip')
luasnip.filetype_extend("ruby", { "rails" })
luasnip.config.setup { history = true, store_selection_keys = "<Tab>", updateevents = "TextChanged, TextChangedI",
  delete_check_events = "TextChanged, TextChangedI" }

local from_vscode = require('luasnip.loaders.from_vscode')
from_vscode.lazy_load()

for _, lang in pairs({ "ruby" }) do
  luasnip.add_snippets(lang, require("snippets." .. lang), { key = lang })
end
