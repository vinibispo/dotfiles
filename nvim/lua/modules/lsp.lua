local saga_definition = require("lspsaga.definition")
local saga_finder = require("lspsaga.finder")
local saga_action = require("lspsaga.action")

local saga_code_action = require("lspsaga.codeaction")

local saga_signature_help = require("lspsaga.signaturehelp")

local saga_rename = require("lspsaga.rename")

local saga_hover = require("lspsaga.hover")

local saga_diagnostic = require("lspsaga.diagnostic")

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local function on_attach(client, buffnr)
  local opts = { silent = true, noremap = true, buffer = buffnr }
  local mappings = {
    { "n", "gd", vim.lsp.buf.definition, opts },
  }

  if client.supports_method("textDocument/definition") then
    table.insert(mappings, { "n", "gd", vim.lsp.buf.definition, opts })
  end

  if client.supports_method("textDocument/previewDefinition") then
    table.insert(mappings, { "n", "gD", saga_definition.preview_definition, opts })
  end

  if client.supports_method("textDocument/rename") then
    table.insert(mappings, { "n", "gr", saga_rename.lsp_rename, opts })
  end

  if client.supports_method("textDocument/references") or client.supports_method("textDocument/definition") then
    table.insert(mappings, { "n", "gh", saga_finder.lsp_finder, opts })
  end

  if client.supports_method("textDocument/codeAction") then
    table.insert(mappings, { "n", "<leader>ca", saga_code_action.code_action, opts })
    table.insert(mappings, {
      "v",
      "<leader>ca",
      function()
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
        saga_code_action.range_code_action()
      end,
      opts,
    })
  end

  if client.supports_method("textDocument/signatureHelp") then
    table.insert(mappings, { "n", "gs", saga_signature_help.signature_help, opts })
  end

  if client.supports_method("textDocument/hover") then
    table.insert(mappings, { "n", "<leader>Z", saga_hover.render_hover_doc, opts })
  end

  if client.supports_method("textDocument/publishDiagnostics") then
    table.insert(mappings, { "n", "[g", saga_diagnostic.goto_next, opts })
    table.insert(mappings, { "n", "]g", saga_diagnostic.goto_prev, opts })
  end

  if client.supports_method("textDocument/formatting") then
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
      "n",
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
  end

  if client.supports_method("textDocument/rangeFormatting") then
    table.insert(mappings, { "v", "<leader>F", vim.lsp.buf.range_formatting, opts })
  end

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

  table.insert(mappings, {
    "n",
    "<C-a>",
    function()
      saga_action.smart_scroll_with_saga(1)
    end,
    opts,
  })

  table.insert(mappings, {
    "n",
    "<C-b>",
    function()
      saga_action.smart_scroll_with_saga(-1)
    end,
    opts,
  })

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
  local new_capabilities = cmp_nvim_lsp.update_capabilities(capabilities)
  local opts = { on_attach = on_attach, capabilities = new_capabilities }
  return opts
end

return { make_config = make_config, on_attach = on_attach }
