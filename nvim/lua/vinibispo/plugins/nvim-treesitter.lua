return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = { "nvim-treesitter/playground", "nkrkv/nvim-treesitter-rescript" },
    init = function()
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldmethod = "expr"
      vim.o.foldenable = false
    end,
    config = function()
      require("nvim-treesitter.configs").setup({
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
        },
      })
    end,
  }, -- TreeSitter Support
}
