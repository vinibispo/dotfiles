require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "python",
    "lua",
    "yaml",
    "json",
    "javascript",
    "bash",
    "typescript",
    "ruby",
  },
  highlight = {enable = true, disable = {}},
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<leader>is",
      node_incremental = "+",
      scope_incremental = "w",
      node_decremental = "-",
    },
  },

  indent = {enable = true},
}
