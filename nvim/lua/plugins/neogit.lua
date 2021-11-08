require('plenary')
local neogit = require("neogit")

neogit.setup {
  disable_signs = false,
  disable_hint = false,
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
  sections = {
    untracked = {folded = false},
    unstaged = {folded = false},
    staged = {folded = false},
    stashes = {folded = true},
    unpulled = {folded = true},
    unmerged = {folded = false},
    recent = {folded = true},
  },
  mappings = {status = {["B"] = "BranchPopup"}},
}
