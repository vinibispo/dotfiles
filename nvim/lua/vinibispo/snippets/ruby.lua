local luasnip = require("luasnip")
local snip = luasnip.snippet
local text = luasnip.text_node
local insert = luasnip.insert_node

-- local function before(snippet)
--   return snippet.env.TM_CURRENT_LINE:match('^(.*)' .. snippet.dscr[1], 1)
-- end

local function convert_snake_case_in_pascal_case(str)
  local words = {}
  for _, v in pairs(vim.split(str, "_")) do -- grab all the words separated with a _ underscore
    table.insert(words, v:sub(1, 1):upper() .. v:sub(2)) -- we take the first character, uppercase, and add the rest. Then I insert to the table
  end
  return table.concat(words, "")
end

local function get_file_without_extension()
  local path = vim.fn.expand("%")
  return path:match("(.+)%..+")
end

local function create_test_class(inherit_from)
  if get_file_without_extension() == nil then
    return
  end

  return text({ "", "", "class " }),
      insert(1, convert_snake_case_in_pascal_case(get_file_without_extension())),
      text({ " < " .. inherit_from, "" }),
      text(" "),
      insert(2, " "),
      text({ "", "end" })
end

local function add_test_helper(str)
  str = str or ""
  if str == "" then
    return text("require 'test_helper'")
  else
    return text("require '" .. str .. "'")
  end
end

local function create_block(name)
  return text(name .. " do"), text({ "", "  " }), insert(0, ""), text({ "", "end" })
end

return {
  snip(
    { trig = "clat", name = "ActiveSupport::TestCase" },
    { add_test_helper(), create_test_class("ActiveSupport::TestCase") }
  ),
  snip({ trig = "clat", name = "ApplicationSystemTestCase" }, {
    add_test_helper("application_system_test_case"),
    create_test_class("ApplicationSystemTestCase"),
  }),
  snip(
    { trig = "clat", name = "ActionDispatch::IntegrationTest" },
    { add_test_helper(), create_test_class("ActionDispatch::IntegrationTest") }
  ),
  snip(
    { trig = "clat", name = "ActionMailer::TestCase" },
    { add_test_helper(), create_test_class("ActionMailer::TestCase") }
  ),
  snip(
    { trig = "clat", name = "ActionView::TestCase" },
    { add_test_helper(), create_test_class("ActionView::TestCase") }
  ),
  snip(
    { trig = "clat", name = "ActiveJob::TestCase" },
    { add_test_helper(), create_test_class("ActiveJob::TestCase") }
  ),
  snip(
    { trig = "clat", name = "Rails::Generators::TestCase" },
    { add_test_helper(), create_test_class("Rails::Generators::TestCase") }
  ),
  snip({ trig = "setup", name = "setup" }, { create_block("setup") }),
  snip({ trig = "tear", name = "teardown" }, { create_block("teardown") }),
  snip({ trig = "as", name = "assert(..)" }, { text("assert "), insert(1, "test") }),
  snip({ trig = "ase", name = "assert_empty(..)" }, { text("assert_empty "), insert(1, "test") }),
  snip({ trig = "asn", name = "assert_nil(..)" }, { text("assert_nil "), insert(1, "instance") }),
  snip({ trig = "ase", name = "assert_equal(..)" }, {
    text("assert_equal "),
    insert(2, "expected"),
    text(", "),
    insert(1, "current"),
  }),
  snip({ trig = "asi", name = "assert_includes(..)" }, {
    text("assert_includes "),
    insert(2, "collection"),
    text(", "),
    insert(1, "item"),
  }),

  snip({ trig = "asio", name = "assert_instance_of(..)" }, {
    text("assert_instance_of "),
    insert(2, "ExpectedClass"),
    text(", "),
    insert(1, "current_instance"),
  }),
  snip({ trig = "asko", name = "assert_kind_of(..)" }, {
    text("assert_kind_of "),
    insert(2, "ExpectedClass"),
    text(", "),
    insert(1, "current_instance"),
  }),
  snip({ trig = "asp", name = "assert_predicate(..)" }, {
    text("assert_predicate "),
    insert(2, "object"),
    text(", :"),
    insert(1, "method"),
    text("?"),
  }),
  snip({ trig = "asrt", name = "assert_respond_to(..)" }, {
    text("assert_respond_to "),
    insert(2, "object"),
    text(", :"),
    insert(1, "method"),
    text("?"),
  }),
  snip({ trig = "ass", name = "assert_same(..)" }, {
    text("assert_same "),
    insert(2, "expected"),
    text(", "),
    insert(1, "current"),
  }),
  snip({ trig = "ass", name = "assert_send(..)" }, {
    text("assert_send "),
    insert(1, "object"),
    text(", :"),
    insert(2, "message"),
    text(", "),
    insert(0, "args"),
  }),
  snip({ trig = "asm", name = "assert_match(..)" }, {
    text("assert_match /"),
    insert(2, "expected_pattern"),
    text("/, "),
    insert(1, "current_string"),
  }),
  snip({ trig = "asid", name = "assert_in_delta(..)" }, {
    text("assert_in_delta "),
    insert(1, "expected_float"),
    text(", "),
    insert(2, "current_float"),
    insert(0, " 2 ** -20"),
  }),
  snip({ trig = "asie", name = "assert_in_epsilon(..)" }, {
    text("assert_in_epsilon "),
    insert(1, "expected_float"),
    text(", "),
    insert(2, "current_float"),
    insert(0, " 2 ** -20"),
  }),
  snip({ trig = "aso", name = "assert_operator(..)" }, {
    text("assert_operator "),
    insert(1, "left"),
    text(", "),
    insert(2, "operator"),
    text(", "),
    insert(0, "right"),
  }),

  snip({ trig = "aso", name = "assert_output(..) { .. }" }, {
    text("assert_output( "),
    insert(1, "stdout"),
    text(", "),
    insert(2, "stderr"),
    text(") { "),
    insert(0),
    text(" }"),
  }),
  snip({ trig = "asr", name = "assert_raises(..) { .. }" }, {
    text("assert_raises("),
    insert(1, "stdout"),
    text(") { "),
    insert(0),
    text(" }"),
  }),
  snip({ trig = "t", name = "test" }, {
    text({ "", "test \"" }),
    insert(1, "the truth"),
    text("\""),
    text({ "", "  " }),
    insert(2, " "),
    text({ "", "  assert " }),
    insert(3, "true"),
    text({ "", "end" }),
  }),
}
