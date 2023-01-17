return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "latte",
        integration = {
          dap = {
            enabled = true,
            enable_ui = true, -- enable nvim-dap-ui
            neotest = true,
          },
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          lsp_trouble = true,
          cmp = true,
          mason = true,
          neogit = true,
          fidget = true,
          neotree = true,
          notify = true,
          treesitter = true,
          telescope = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
      vim.o.background = "light"
      vim.cmd.colorscheme("catppuccin")
    end,
    priority = 1000,
  }, -- Colorscheme
}
