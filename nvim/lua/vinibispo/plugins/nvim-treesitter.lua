local function setup()
  require("nvim-treesitter.configs").setup({
    highlight = { enable = true, disable = {} },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<leader>is",
        node_incremental = "+",
        scope_incremental = "w",
        node_decremental = "-",
      },
      indent = { enable = true },
    },
  })
end

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/playground" },
    init = function()
      vim.o.foldexpr = "nvim_treesitter#foldexpr()"
      vim.o.foldmethod = "expr"
    end,
    config = setup,
  }, -- TreeSitter Support
}
