return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "latte",
      })
      vim.o.background = "light"
      vim.cmd.colorscheme("catppuccin")
    end,
    priority = 1000,
  }, -- Colorscheme
}
