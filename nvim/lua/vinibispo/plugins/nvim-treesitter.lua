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
    config = setup,
  }, -- TreeSitter Support
}
