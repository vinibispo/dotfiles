local function setup()
  require("mason").setup()

  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  local lsp = require("vinibispo.modules.lsp")

  mason_lspconfig.setup()
  mason_lspconfig.setup_handlers({
    function(name)
      return lspconfig[name].setup(lsp.make_config())
    end,
    ["lua_ls"] = function()
      local config = lsp.make_config()
      config.settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim", "use_rocks" } },
        },
      }

      return lspconfig.lua_ls.setup(config)
    end,
    ["grammarly"] = function()
      local config = lsp.make_config()
      config.filetypes = { "markdown", "gitcommit", "NeogitCommitMessage" }
      return lspconfig.grammarly.setup(config)
    end,

    require("typescript-tools").setup({
      on_attach = lsp.on_attach,
      settings = {
        tsserver_file_preferences = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    }),
  })
end

return {
  {
    event = "BufReadPost",
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "pmizio/typescript-tools.nvim",
    },
    config = setup,
  },                                       --Neovim LSP Config
  { "folke/trouble.nvim", config = true }, --LSP Diagnostic List
  {
    "j-hui/fidget.nvim",
    opts = {},
  }, -- LSP Progress Spinner
}
