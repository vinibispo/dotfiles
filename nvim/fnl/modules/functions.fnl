(local M {})
(fn setup [package config]
  (#(let [p (require package)] (p.setup config) ))
)
(set M.setup setup)

M
