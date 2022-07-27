local mason_lspconfig = require("mason-lspconfig")
local lsp = require("modules.lsp")

local lspconfig = require("lspconfig")

local saga = require("lspsaga")

local null_ls = require("null-ls")

saga.init_lsp_saga()

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

mason_lspconfig.setup_handlers({
  function(name)
    return lspconfig[name].setup(lsp.make_config())
  end,
  ["sumneko_lua"] = function()
    local config = lsp.make_config()
    config.settings = {
      Lua = {
        runtime = { version = "LuaJIT" },
        diagnostics = { globals = { "vim", "use_rocks" } },
      },
    }

    return lspconfig.sumneko_lua.setup(config)
  end,
})
