return {
  {
    "windwp/nvim-autopairs",
    -- event = "InsertEnter",
    config = function()
      local pairs = require("nvim-autopairs")
      pairs.setup({
        disable_in_macro = true,
        enable_check_bracket_line = false,
      })
      pairs.get_rule("'")[1].not_filetypes = {
        "clojure",
        "scheme",
        "fennel",
        "lisp",
      }
    end,
  },
}
