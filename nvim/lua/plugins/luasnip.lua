local luasnip = require("luasnip")
luasnip.filetype_extend('ruby', {'rails'})
local fn = vim.fn
luasnip.config.setup {
  history = true,
  store_selection_keys = '<TAB>',
  updateevents = 'TextChanged,TextChangedI',
  delete_check_events = 'TextChanged,InsertLeave',
}

local snip = luasnip.snippet
local node = luasnip.snippet_node
local text = luasnip.text_node
local insert = luasnip.insert_node
local choice = luasnip.choice_node
local dynamic = luasnip.dynamic_node

local function before(snippet)
  return snippet.env.TM_CURRENT_LINE:match('^(.*)' .. snippet.dscr[1], 1)
end

local function split(str, sep)
  local new_sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", new_sep)
  _ = str:gsub(pattern, function(c)
    fields[#fields + 1] = c
  end)
  return fields
end

local function convert_snake_case_in_pascal_case(str)
  local words = {}
  for i, v in pairs(split(str, '_')) do -- grab all the words separated with a _ underscore
    table.insert(words, v:sub(1, 1):upper() .. v:sub(2)) -- we take the first character, uppercase, and add the rest. Then I insert to the table
  end
  return table.concat(words, "")
end

local function get_file_without_extension()
  local path = fn.expand('%')
  return path:match('(.+)%..+')
end
local function create_test_class(inherit_from)
  return text {'', '', 'class '},
         insert(1, convert_snake_case_in_pascal_case(get_file_without_extension())),
         text({' < ' .. inherit_from, ''}), text(' '), insert(2, ' '), text {'', 'end'}
end

local function add_test_helper(str)
  str = str or ''
  if str == '' then
    return text("require 'test_helper'")
  else
    return text("require '" .. str .. "'")
  end
end

luasnip.snippets = {
  lua = {
    snip('func', {
      dynamic(1, function(_, snippet)
        local line = before(snippet)
        if line == '' then
          return node(nil, choice(1, {text 'local ', text ''}))
        elseif line:match '^%s*$' then
          return node(nil, choice(1, {text '', text 'local '}))
        end
        return node(nil, text '')
      end, {}),
      text 'function',
      dynamic(2, function(args, snippet)
        if not before(snippet):match '^%s*$' then
          return node(nil, text '')
        elseif args[1][1] ~= 'local ' then
          return node(nil, {choice(1, {text ' M.', text ' '}), insert(2, 'name')})
        end
        return node(nil, {text ' ', insert(1, 'name')})
      end, {1}),
      text '(',
      insert(3, 'param'),
      text {')', '\t'},
      dynamic(4, function(_, snippet)
        local vis = snippet.env.TM_SELECTED_TEXT[1]
        if vis then
          return node(nil, {text(vis), insert(1)})
        else
          return insert(1, placeholder or '')
        end
      end, {}),
      text {'', 'end'},
    }),
  },

  ruby = {
    snip({trig = 'astc', name = 'ActiveSupport::TestCase'},
         {add_test_helper(), create_test_class('ActiveSupport::TestCase')}),
    snip({trig = 'apstc', name = 'ApplicationSystemTestCase'}, {
      add_test_helper('application_system_test_case'),
      create_test_class('ApplicationSystemTestCase'),
    }),
    snip({trig = 'adit', name = 'ActionDispatch::IntegrationTest'},
         {add_test_helper(), create_test_class('ActionDispatch::IntegrationTest')}),
    snip({trig = 't', name = 'test'}, {
      text {'', 'test "'},
      insert(1, 'the truth'),
      text(""),
      text({'', '  '}),
      insert(2, ' '),
      text({'', '  assert '}),
      insert(3, 'true'),
      text({'', 'end'}),
    }),
  },
}
require("luasnip/loaders/from_vscode").lazy_load()
