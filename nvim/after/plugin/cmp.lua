local cmp = require('cmp')
local lspkind = require('lspkind')
local luasnip = require('luasnip')

local function has_words_before()
  local table = vim.api.nvim_win_get_cursor(0)
  local line = table[1]
  local col = table[2]
  local has = (
      (0 ~= col) and (nil == ((vim.api.nvim_buf_get_lines(0, (line - 1), line, true))[1]):sub(col, col):match("%s")))
  return has
end

cmp.setup { snippet = {
  expand = function(args)
    luasnip.lsp_expand(args.body)
  end
},
  formatting = { format = lspkind.cmp_format { width_text = false, max_width = 50,
    menu = { buffer = "[Buffer]", nvim_lsp = "[LSP]", luasnip = "[LuaSnip]", nvim_lua = "[Lua]", path = "[Path]" },
    documentation = { border = "single" }
  } },
  mapping = { ["<Tab>"] = cmp.mapping(function(fallback)
    if (cmp.visible()) then
      return cmp.select_next_item()
    end

    if (luasnip.expand_or_jumpable()) then
      return luasnip.expand_or_jump()
    end

    if (has_words_before()) then
      return cmp.complete()
    end
    return fallback()
  end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if (cmp.visible()) then
        return cmp.select_prev_item()
      end

      if (luasnip.jumpable(-1)) then
        return luasnip.jump(-1)
      end

      return fallback()
    end, { "i", "s" }),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true }
  },
  sources = { { name = "buffer" }, { name = "nvim_lsp" }, { name = "nvim_lua" }, { name = "path" }, { name = "spell" },
    { name = "treesitter" }, { name = "luasnip" } }


}
