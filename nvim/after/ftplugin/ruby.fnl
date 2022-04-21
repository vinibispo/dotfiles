(local (ok ruby_nvim) (pcall require :ruby_nvim))
(when (not ok)
  (lua "return true"))

(ruby_nvim.setup {:test_cmd :ruby :test_args {}})
