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

local ruby_like = vim.api.nvim_create_augroup("ruby like", { clear = true })
vim.api.nvim_create_autocmd(
  "BufEnter",
  { pattern = "*{.json.jbuilder,.xlsx.axlsx}", command = "set filetype=ruby", group = ruby_like }
)
