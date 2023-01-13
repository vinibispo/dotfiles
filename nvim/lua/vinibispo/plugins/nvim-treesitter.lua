return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/playground" },
    init = function()
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldmethod = "expr"
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        incremental_selection = {
          enable = true,
          indent = { enable = true },
        },
      })
    end,
  }, -- TreeSitter Support
}
