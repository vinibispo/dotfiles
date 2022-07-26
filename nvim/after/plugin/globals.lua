function P(v)
  vim.notify(vim.inspect(v))
end

local function RELOAD(...)
  require("plenary.reload").reload_module(...)
end

function R(name)
  RELOAD(name)
  vim.notify(name .. " " .. "reloaded")
  require(name)
end
