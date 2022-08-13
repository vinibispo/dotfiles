local lsp = require("modules.lsp")

local null_ls = require("null-ls")

null_ls.setup({
  on_attach = lsp.on_attach,
  save_after_format = false,
  sources = {
    null_ls.builtins.diagnostics.rubocop,
    null_ls.builtins.formatting.rubocop,
    null_ls.builtins.formatting.erb_lint,
    null_ls.builtins.diagnostics.erb_lint,
    null_ls.builtins.code_actions.eslint,
    null_ls.builtins.formatting.eslint,
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.stylua,
  },
})
