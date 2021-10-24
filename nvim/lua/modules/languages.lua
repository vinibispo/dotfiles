local M = {}
function M.js()
  vim.env.PATH = "node_modules/.bin:" .. vim.env.PATH
end
return M
