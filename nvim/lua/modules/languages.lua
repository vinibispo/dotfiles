local M = {}
function M.js()
  vim.env.PATH = "node_modules/.bin:" .. vim.env.PATH
  vim.bo.makeprg = "eslint -f compact %"
  vim.opt.errorformat:append('%f:line%l,col%c,%m,%-G%.%#')
end
return M
