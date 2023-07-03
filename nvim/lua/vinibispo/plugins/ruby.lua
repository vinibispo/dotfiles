return {
  {
    "rgroli/other.nvim",
    setup = function()
      require("other-nvim").setup({
        mappings = {
          "rails"
        }
      })
    end
  }
}
