local saga_definition = require("lspsaga.definition")
local saga_finder = require("lspsaga.finder")

local saga_code_action = require("lspsaga.codeaction")

local saga_rename = require("lspsaga.rename")

local saga_hover = require("lspsaga.hover")

local saga_diagnostic = require("lspsaga.diagnostic")

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local function on_attach(client, buffnr)
  vim.api.nvim_buf_set_option(buffnr, "omnifunc", "v:lua.lsp.omnifunc")
  local opts = { silent = true, noremap = true, buffer = buffnr }
  local mappings = {}

  table.insert(mappings, {
    "n",
    "gd",
    vim.lsp.buf.definition,
    opts,
  })

  table.insert(mappings, {
    "n",
    "gD",
    function()
      saga_definition:peek_definition()
    end,
    opts,
  })

  table.insert(mappings, {
    "n",
    "gr",
    function()
      saga_rename:lsp_rename()
    end,
    opts,
  })

  table.insert(mappings, {
    "n",
    "gh",
    function()
      saga_finder:lsp_finder()
    end,
    opts,
  })

  table.insert(mappings, {
    "n",
    "<leader>ca",
    function()
      saga_code_action:code_action()
    end,
    opts,
  })
  table.insert(mappings, {
    "v",
    "<leader>ca",
    function()
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
      saga_code_action:code_action()
    end,
    opts,
  })

  table.insert(mappings, { "n", "gs", vim.lsp.buf.signature_help, opts })

  table.insert(mappings, {
    "n",
    "<leader>Z",
    function()
      saga_hover:render_hover_doc()
    end,
    opts,
  })

  table.insert(mappings, { "n", "[g", saga_diagnostic.goto_next, opts })
  table.insert(mappings, { "n", "]g", saga_diagnostic.goto_prev, opts })

  local function format_lsp(bufnr)
    vim.lsp.buf.format({
      filter = function(_)
        return true
      end,
      bufnr = bufnr,
    })
  end

  local lsp_formatting = vim.api.nvim_create_augroup("lsp_formatting", { clear = true })
  table.insert(mappings, {
    { "n", "v" },
    "<leader>F",
    function()
      format_lsp(buffnr)
    end,
    opts,
  })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = lsp_formatting,
    buffer = buffnr,
    callback = function()
      format_lsp(buffnr)
    end,
  })

  if client.supports_method("textDocument/highlight") then
    local lsp_document_highlight = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_create_autocmd(
      "CursorHold",
      { pattern = "<buffer>", group = lsp_document_highlight, callback = vim.lsp.buf.document_highlight }
    )

    vim.api.nvim_create_autocmd(
      "CursorMoved",
      { pattern = "<buffer>", group = lsp_document_highlight, callback = vim.lsp.buf.clear_references }
    )
  end

  for _, val in pairs(mappings) do
    vim.keymap.set(unpack(val))
  end
end

local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { "documentation", "detail", "additionalTextEdits" },
  }
  local new_capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
  local opts = { on_attach = on_attach, capabilities = new_capabilities }
  return opts
end

return { make_config = make_config, on_attach = on_attach }
