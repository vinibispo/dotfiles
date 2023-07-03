local function js()
  vim.env.PATH = "node_modules/.bin:" .. vim.env.PATH
end

local function cf()
  vim.opt_local.noendofline = true
end

return {
  js = js,
  cf = cf,
}
