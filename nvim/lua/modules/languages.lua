local function js()
  vim.env.PATH = "node_modules/.bin:" .. vim.env.PATH
end

return {
  js = js,
}
