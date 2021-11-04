require('plenary')
local neogit = require("neogit")

neogit.setup {
  disable_signs = false,
  disable_context_highlighting = false,
  disable_commit_confirmation = false,
  auto_refresh = true,
  commit_popup = {kind = "split"},
  -- customize displayed signs
  signs = {
    -- { CLOSED, OPENED }
    section = {">", "v"},
    item = {">", "v"},
    hunk = {"", ""},
  },
  integrations = {diffview = true},
}
