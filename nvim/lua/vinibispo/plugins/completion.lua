local function config()
  local cmp = require("cmp")
  local lspkind = require("lspkind")
  local luasnip = require("luasnip")
  local style = require("vinibispo.modules.style")

  local function has_words_before()
    local table = vim.api.nvim_win_get_cursor(0)
    local line = table[1]
    local col = table[2]
    local has = (
        (0 ~= col) and (nil == ((vim.api.nvim_buf_get_lines(0, (line - 1), line, true))[1]):sub(col, col):match("%s"))
        )
    return has
  end

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    window = {
      completion = {
        border = style.set_border("CmpBorder"),
      },
      documentation = {
        border = style.set_border("CmpDocBorder"),
      },
    },
    formatting = {
      format = lspkind.cmp_format({
        width_text = false,
        max_width = 50,
        menu = {
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          path = "[Path]",
          treesitter = "[TS]",
        },
        documentation = { border = "single" },
      }),
    },
    mapping = {
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.select_next_item()
        end

        if luasnip.expand_or_jumpable() then
          return luasnip.expand_or_jump()
        end

        if has_words_before() then
          return cmp.complete()
        end
        return fallback()
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.select_prev_item()
        end

        if luasnip.jumpable(-1) then
          return luasnip.jump(-1)
        end

        return fallback()
      end, { "i", "s" }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
    },
    sources = {
      { name = "buffer" },
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "spell" },
      { name = "treesitter" },
      { name = "luasnip" },
    },
  })

  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=] },
    }),
  })

  cmp.setup.cmdline(":!", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline", keyword_pattern = [=[[^[:blank:]\!]*]=], keyword_length = 3 },
    }),
  })
end

local function luasnip_config()
  local luasnip = require("luasnip")
  local function setup()
    luasnip.filetype_extend("ruby", { "rails" })
    luasnip.config.setup({
      history = true,
      updateevents = "TextChanged, TextChangedI",
      delete_check_events = "TextChanged, TextChangedI",
    })

    local from_vscode = require("luasnip.loaders.from_vscode")
    from_vscode.lazy_load()

    for _, lang in pairs({ "ruby" }) do
      luasnip.add_snippets(lang, require("vinibispo.snippets." .. lang), { key = lang })
    end
  end

  setup()
end

return {
  {
    "L3MoN4D3/LuaSnip",
    config = luasnip_config,
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    keys = {

      {
        "<C-j>",
        function()
          require("luasnip").jump(1)
        end,
        mode = { "i", "s" },
        desc = "Luasnip [J]ump Next",
      },
      {
        "<C-i>",
        function()
          require("luasnip").jump(-1)
        end,
        mode = { "i", "s" },
        desc = "Luasnip Jump Prev[I]ous",
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = config,
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = {
      -- Completion
      "hrsh7th/nvim-cmp",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "ray-x/cmp-treesitter",
      -- Snippet
      "saadparwaiz1/cmp_luasnip",
      "L3MoN4D3/LuaSnip",
      -- Style
      "onsails/lspkind-nvim",
    },
  }, -- Completion
}
