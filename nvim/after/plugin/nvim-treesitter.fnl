(local {: setup} (require :modules.functions))

(setup :nvim-treesitter.configs
       {:ensure_installed [:python
                           :lua
                           :yaml
                           :json
                           :javascript
                           :bash
                           :typescript
                           :ruby
                           :tsx
                           :fennel]
        :highlight {:enable true :disable {}}
        :incremental_selection {:enable true
                                :keymaps {:init_selection :<leader>is
                                          :node_incremental "+"
                                          :scope_incremental :w
                                          :node_decremental "-"}
                                :indent {:enable true}}})
