local line_numbers = vim.api.nvim_create_augroup("line_numbers", { clear = false })
local function set_relative_number(boolean)
  if not (type(boolean) == "boolean") then
    boolean = true
  end
  vim.o.relativenumber = boolean
end

vim.api.nvim_create_autocmd(
  { "BufEnter", "FocusGained", "InsertEnter", "InsertLeave" },
  { pattern = "*", callback = set_relative_number, group = line_numbers }
)
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
  pattern = "*",
  group = line_numbers,
  callback = function()
    set_relative_number(false)
  end,
})

local jbuilder = vim.api.nvim_create_augroup("jbuilder", { clear = true })
vim.api.nvim_create_autocmd(
  "BufEnter",
  { pattern = "*.json.jbuilder", command = "set filetype=ruby", group = jbuilder }
)

local packer = vim.api.nvim_create_augroup("PackerUserConfig", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
  group = packer,
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile profile=true",
})
