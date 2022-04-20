-- :fennel:1650454302
do
  local augid_1_ = vim.api.nvim_create_augroup("line_numbers", {clear = true})
  local function _2_()
    vim.opt["relativenumber"] = true
    return nil
  end
  vim.api.nvim_create_autocmd({"BufEnter", "FocusGained", "InsertEnter", "InsertLeave"}, {callback = _2_, group = augid_1_, nested = false, once = false, pattern = "*"})
  local function _3_()
    vim.opt["relativenumber"] = false
    return nil
  end
  vim.api.nvim_create_autocmd({"BufLeave", "FocusLost"}, {callback = _3_, group = augid_1_, nested = false, once = false, pattern = "*"})
end
do
  local augid_4_ = vim.api.nvim_create_augroup("jbuilder", {clear = true})
  vim.api.nvim_create_autocmd({"BufEnter"}, {command = "set filetype=ruby", group = augid_4_, nested = false, once = false, pattern = "json.jbuilder"})
end
do
  local augid_5_ = vim.api.nvim_create_augroup("packer", {clear = true})
  vim.api.nvim_create_autocmd({"BufWritePost"}, {command = "PackerCompile", group = augid_5_, nested = false, once = false, pattern = "plugins.lua"})
end
local function format_fennel()
  if (1 == vim.fn.executable("fnlfmt")) then
    vim.cmd(":silent !fnlfmt --fix %")
    return true
  else
    return nil
  end
end
local function source_file()
  local file_name = vim.fn.expand("%:r")
  local config_folder = vim.fn.stdpath("config")
  local lua_file = (config_folder .. "/" .. vim.fn.expand("%:p:.:gs?fnl?lua?"))
  local source_file0
  if (file_name == "init") then
    source_file0 = (config_folder .. "/lua/tangerine_vimrc.lua")
  else
    source_file0 = lua_file
  end
  do
    vim.cmd((":source  " .. (source_file0 .. "")))
  end
  return print(("sourced: " .. source_file0))
end
local augid_8_ = vim.api.nvim_create_augroup("_config", {clear = true})
vim.api.nvim_create_autocmd({"BufWritePost"}, {callback = source_file, group = augid_8_, nested = false, once = false, pattern = "*.fnl"})
return vim.api.nvim_create_autocmd({"BufWritePost"}, {callback = format_fennel, group = augid_8_, nested = false, once = false, pattern = "*.fnl"})