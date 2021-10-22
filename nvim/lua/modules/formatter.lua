-- formatter modules
local function prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true,
  }
end

local function eslint()
  return {
    exe = 'eslint',
    args = {"--stdin-filename", vim.api.nvim_buf_get_name(0), "--fix", "--cache"},
    stdin = false,
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
    javascriptreact = {eslint},
    markdown = {prettier},
    typescript = {eslint},
    typescriptreact = {eslint},
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
vim.api.nvim_exec([[
    augroup FormatAu
        autocmd!
        autocmd BufWritePost *.lua,*.json,*.rb,*.js,*.jsx,*.ts,*.tsx,*.md FormatWrite
    augroup END
]], true)
