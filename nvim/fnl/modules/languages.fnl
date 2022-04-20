(local M {})
(fn js []
  (set vim.env.PATH (.. "node_modules/.bin:" vim.env.PATH))
)

(set M.js js)
