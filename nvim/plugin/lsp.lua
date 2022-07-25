local saga_definition = require("lspsaga.definition")
local mason_lspconfig = require('mason-lspconfig')

local saga_action = require("lspsaga.action")

local saga_code_action = require('lspsaga.codeaction')

local saga_signature_help = require("lspsaga.signaturehelp")

local saga_hover = require("lspsaga.hover")

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local lspconfig = require("lspconfig")

local saga = require("lspsaga")

local null_ls = require("null-ls")

saga.init_lsp_saga()

local function on_attach (client, buffnr)
  local opts = { silent = true, noremap = true, buffer = buffnr }
  local mappings = {
    { "n", "gd", vim.lsp.buf.definition, opts }
  }
  for _, val in pairs(mappings) do
    vim.keymap.set(unpack(val))
  end
end


local function make_config (client_name)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem['snippetSupport'] = true
  capabilities.textDocument.completion.completionItem['resolveSupport'] = { properties = { 'documentation', 'detail', 'additionalTextEdits' } }
  local new_capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  local opts = { on_attach = on_attach, capabilities = new_capabilities }
  if (client_name == 'sumneko_lua') then
    opts["settings"] = { Lua = { diagnostics = { globals = { "vim" } } } }
  end
  return opts
end

null_ls.setup { on_attach = on_attach, save_after_format = false, sources = {
null_ls.builtins.formatting.fnlfmt,
                          null_ls.builtins.diagnostics.rubocop,
                          null_ls.builtins.formatting.rubocop,
                          null_ls.builtins.formatting.erb_lint,
                          null_ls.builtins.diagnostics.erb_lint,
                          null_ls.builtins.code_actions.eslint,
                          null_ls.builtins.formatting.eslint,
                          null_ls.builtins.diagnostics.eslint
} }


mason_lspconfig.setup_handlers {
  function (name)
    lspconfig[name].setup(make_config(name))
  end
}
