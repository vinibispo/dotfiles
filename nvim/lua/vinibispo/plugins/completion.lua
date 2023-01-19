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
      format = function(entry, vim_item)
        if vim.tbl_contains({ "path" }, entry.source.name) then
          local icon, hl_group = require("nvim-web-devicons").get_icon(entry:get_completion_item().label)
          if icon then
            vim_item.kind = icon
            vim_item.kind_hl_group = hl_group
            return vim_item
          end
        end
        return lspkind.cmp_format({ with_text = true })(entry, vim_item)
      end,
    },
    mapping = {
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
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
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          return cmp.select_prev_item()
        end

        if luasnip.jumpable(-1) then
          return luasnip.jump(-1)
        end

        return fallback()
      end, { "i", "s" }),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping({
        i = cmp.mapping.abort(),
        s = cmp.mapping.close(),
      }),
      ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
      ["<C-y>"] = cmp.mapping.confirm({ select = true }),
      ["<C-q>"] = cmp.mapping(function()
        vim.api.nvim_feedkeys(
          vim.fn["copilot#Accept"](vim.api.nvim_replace_termcodes("<c-q>", true, true, true)),
          "n",
          true
        )
      end),
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
      {
        "github/copilot.vim",
        init = function()
          vim.g.copilot_no_tab_map = true
          vim.g.copilot_assume_mapped = true
          vim.g.copilot_filetypes = { ["dap-repl"] = false }
        end,
      },
      -- Snippet
      "saadparwaiz1/cmp_luasnip",
      "L3MoN4D3/LuaSnip",
      -- Style
      "onsails/lspkind-nvim",
    },
  }, -- Completion
}
