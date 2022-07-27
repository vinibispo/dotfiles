require("mason").setup()

local lspconfig = require("lspconfig")
local mason_lspconfig = require("mason-lspconfig")
local lsp = require("modules.lsp")

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
