local installer = require("nvim-lsp-installer")
local servers = require("nvim-lsp-installer.servers")
local lsp = require("lspconfig")
local saga = require("lspsaga")

saga.init_lsp_saga({
  error_sign = "✗",
  warn_sign = "⚠",
  code_action_prompt = {
    enable = true,
    sign = true,
    sign_priority = 20,
    virtual_text = true,
  },
})

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")

  local opts = {silent = true, noremap = true}
  local mappings = {
    {"n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts},
    {"n", "gD", [[<Cmd>lua require('lspsaga.provider').preview_definition()<CR>]], opts},
    {"n", "gr", [[<Cmd>lua require('lspsaga.rename').rename()<CR>]], opts},
    {"n", "gh", [[<Cmd>lua require'lspsaga.provider'.lsp_finder()]], opts},
    {
      "n",
      "<leader>ca",
      [[<Cmd>lua require('lspsaga.codeaction').range_code_action()<CR>']],
      opts,
    },
    {
      "v",
      "<leader>ca",
      [[<Cmd>lua require('lspsaga.codeaction').range_code_action()<CR>']],
      opts,
    },
    {"n", "ca", [[<Cmd>lua require('lspsaga.codeaction).code_action()<CR>]], opts},
    {"v", "ca", [[<Cmd>lua require('lspsaga.codeaction).code_action()<CR>]], opts},
    {
      "n",
      "<C-a>",
      [[<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]],
      opts,
    },
    {
      "n",
      "<C-b>",
      [[<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]],
      opts,
    },
    {
      "n",
      "gR",
      [[<Cmd>lua require('telescope.builtin').lsp_references({ path_display = 'shorten' })<CR>]],
      {noremap = true, silent = true},
    },
    {
      "n",
      "gs",
      [[<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
      opts,
    },
    {"n", "Z", [[<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]], opts},
    {
      "n",
      "[g",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_next()<CR>]],
      opts,
    },
    {
      "n",
      "]g",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev() <CR>]],
      opts,
    },
  }

  for _, map in pairs(mappings) do
    vim.api.nvim_buf_set_keymap(bufnr, unpack(map))
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F",
                                "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.resolved_capabilities.document_range_formatting then
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>F",
                                "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
    augroup lsp_document_highlight
    autocmd! * <buffer>
    autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
    autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]], false)
  end

end

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {"documentation", "detail", "additionalTextEdits"},
  }
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

  return {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {Lua = {diagnostics = {globals = {"vim"}}}},
  }
end

local function setup_servers()
  local installed_servers = servers.get_installed_servers()
  local required_servers = {
    "bashls",
    "cssls",
    "dockerls",
    "graphql",
    "html",
    "jsonls",
    "sumneko_lua",
    "pylsp",
    "solargraph",
    "tsserver",
    "yamlls",
  }
  local installed_servers = {}
  for _, server in pairs(servers.get_installed_servers()) do
    table.insert(installed_servers, server.name)
  end

  for _, server in pairs(required_servers) do
    if not vim.tbl_contains(installed_servers, server) then
      installer.install(server)
      table.insert(installed_servers, server)
    end
  end
end

setup_servers()

lspinstall.post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end
