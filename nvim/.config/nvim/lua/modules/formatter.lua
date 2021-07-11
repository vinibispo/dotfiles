-- formatter modules
local function prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true,
  }
end

require("formatter").setup({
  logging = false,
  filetype = {
    lua = {
      function()
        return {
          exe = "lua-format",
          args = {"-c " .. vim.fn.expand("~/.config/nvim/lua/.lua-format")},
          stdin = true,
        }
      end,
    },
    javascript = {prettier},
    javascriptreact = {prettier},
    markdown = {prettier},
    typescript = {prettier},
    typescriptreact = {prettier},
    json = {
      function()
        return {
          exe = "prettier",
          args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "json"},
          stdin = true,
        }
      end,
    },
    ruby = {
      function()
        return {
          exe = "rubocop",
          stdin = true,
          args = {
            "--stdin",
            vim.api.nvim_buf_get_name(0),
            "--stderr",
            "--auto-correct-all",
          },
        }
      end,
    },
  },
})
-- adding format on save autocmd
vim.api.nvim_exec([[
    augroup FormatAu
        autocmd!
        autocmd BufWritePost *.lua,*.json,*.rb,*.ts,*.tsx,*.md FormatWrite
    augroup END
]], true)
