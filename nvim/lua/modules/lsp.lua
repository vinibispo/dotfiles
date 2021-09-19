-- lsp configs
local lsp = require("lspconfig")
local saga = require("lspsaga")
local lspinstall = require("lspinstall")
saga.init_lsp_saga({error_sign = "✗", warn_sign = "⚠"})

-- configure completion

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local function on_attach(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.lsp.omnifunc")

  local opts = {silent = true, noremap = true}
  local mappings = {
    {"n", "gD", [[<Cmd>lua require('lspsaga.provider').preview_definition()<CR>]], opts},
    {"n", "gd", [[<Cmd>lua vim.lsp.buf.definition()<CR>]], opts},
    {"n", "gr", [[<Cmd>lua require('lspsaga.rename').rename()<CR>]], opts},
    {
      "n",
      "gs",
      [[<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
      opts,
    },
    {
      "n",
      "<leader>gR",
      [[<Cmd>lua require("telescope.builtin").lsp_references{ shorten_path = true }<CR>]],
      {noremap = true, silent = true},
    },
    {
      "i",
      "<C-x>",
      [[<Cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>]],
      opts,
    },
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
    {
      "n",
      "]e",
      [[<Cmd>lua require('lspsaga.diagnostic').lsp_jump_diagnostic_prev() <CR>]],
      opts,
    },
  }

  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca",
                              [[<Cmd>lua require('lspsaga.codeaction').code_action()<CR>]],
                              opts)

  vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>ca",
                              [[<Cmd>lua require('lspsaga.codeaction').range_code_action()<CR>]],
                              opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', "<C-a>",
                              [[<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>]],
                              opts)

  vim.api.nvim_buf_set_keymap(bufnr, 'n', "<C-b>",
                              [[<Cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>]],
                              opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "Z",
                              [[<Cmd>lua require('lspsaga.hover').render_hover_doc()<CR>]],
                              opts)

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
    properties = {'documentation', 'detail', 'additionalTextEdits'},
  }
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  return {
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {Lua = {diagnostics = {globals = {"vim"}}}},
  }

end

local function setup_servers()
  local installed_servers = lspinstall.installed_servers()
  local required_servers = {
    "lua",
    "typescript",
    "python",
    "bash",
    "yaml",
    "vim",
    "ruby",
  }
  for _, svr in pairs(required_servers) do
    if not vim.tbl_contains(installed_servers, svr) then
      lspinstall.install_server(svr)
    end
  end

  lspinstall.setup()
  installed_servers = lspinstall.installed_servers()

  for _, server in pairs(installed_servers) do
    local config = make_config()
    lsp[server].setup(config)
  end
end

setup_servers()

lspinstall.post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end
