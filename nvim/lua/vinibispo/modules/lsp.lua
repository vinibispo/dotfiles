local cmp_nvim_lsp = require("cmp_nvim_lsp")
local style = require("vinibispo.modules.style")
local function publish_diagnostics()
  vim.diagnostic.config({
    virtual_text = false,
  })
  local diagnostics_hold = vim.api.nvim_create_augroup("DiagnosticsCursorHold", { clear = true })
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = diagnostics_hold,
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float(nil, {
        focus = false,
        scope = "cursor",
        source = "always",
      })
    end,
  })
  if not vim.g.diagnostics_active then
    vim.api.nvim_del_augroup_by_id(diagnostics_hold)
  end
end

local function on_attach(client, buffnr)
  publish_diagnostics()
  vim.api.nvim_buf_set_option(buffnr, "omnifunc", "v:lua.lsp.omnifunc")
  local function map(mode, key, func, desc)
    if desc then
      desc = "LSP: " .. desc
    end
    vim.keymap.set(mode, key, func, { silent = true, buffer = buffnr, desc = desc })
  end

  local function nmap(key, func, desc)
    map("n", key, func, desc)
  end

  local function vmap(key, func, desc)
    map("v", key, func, desc)
  end

  local function format_lsp(bufnr)
    vim.lsp.buf.format({
      filter = function(client)
        return client.name ~= "solargraph"
      end,
      bufnr = bufnr,
    })
  end

  local normal_mappings = {

    {
      "gd",
      vim.lsp.buf.definition,
      "[G]oto [D]efinition",
    },

    {
      "<leader>rn",
      vim.lsp.buf.rename,
      "[R]e[n]ame",
    },

    {
      "gr",
      require("telescope.builtin").lsp_references,
      "[G]oto [R]eferences",
    },

    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      "[C]ode [A]ction",
    },

    { "<C-k>", vim.lsp.buf.signature_help, "Signature Documentation" },

    {
      "K",
      vim.lsp.buf.hover,
      "Signature Documentation",
    },

    { "[g", vim.diagnostic.goto_next, "[G]oto Next" },
    { "]g", vim.diagnostic.goto_prev, "[G]oto Prev" },
    {
      "<leader>F",
      function()
        format_lsp(buffnr)
      end,
      "[F]ormat",
    },
  }

  local lsp_formatting = vim.api.nvim_create_augroup("lsp_formatting", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePre", {
    group = lsp_formatting,
    buffer = buffnr,
    callback = function()
      format_lsp(buffnr)
    end,
  })

  for _, val in pairs(normal_mappings) do
    nmap(unpack(val))
  end

  local visual_mappings = {
    {
      "<leader>F",
      function()
        format_lsp(buffnr)
      end,
      "[F]ormat",
    },
    {
      "<leader>ca",
      vim.lsp.buf.code_action,
      "[C]ode [A]ction",
    },
  }

  for _, val in pairs(visual_mappings) do
    vmap(unpack(val))
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

return { make_config = make_config, on_attach = on_attach, publish_diagnostics = publish_diagnostics }
