return {
  {
    "vinibispo/ruby.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
    ft = { "ruby" },
    opts = {
      test_cmd = "ruby",
      test_args = {},
    },
  }, -- Ruby general
}
