(fn P [v]
  (vim.notify (vim.inspect v)))

(fn RELOAD [...]
  (let [plenary_reload (require :plenary.reload)]
    (plenary_reload.reload_module ...)))

(fn R [name]
  (RELOAD name)
  (vim.notify (.. name " " :reloaded))
  (require name))

(set _G.P P)
(set _G.R R)
