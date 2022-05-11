(require-macros :hibiscus.vim)

(command! [] :Bdall "%bd|e#bd#")

(vim.api.nvim_create_user_command :R
                                  (fn [opts]
                                    (_G.R opts.args))
                                  {:nargs 1})
