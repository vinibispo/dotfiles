local lsp = require("vinibispo.modules.lsp")
vim.g.diagnostics_active = true
vim.diagnostic.config({ virtual_text = false })
local function toggle_diagnostics()
  if vim.g.diagnostics_active then
    vim.g.diagnostics_active = false
    lsp.publish_diagnostics()
    vim.diagnostic.hide()
  else
    vim.g.diagnostics_active = true
    lsp.publish_diagnostics()
  end
end

vim.keymap.set(
  "n",
  "<leader>td",
  toggle_diagnostics,
  { desc = "LSP: Toggle Diagnostics ", silent = true, noremap = true }
)
