(local luasnip (require :luasnip))
(luasnip.filetype_extend :ruby [:rails])
(luasnip.config.setup {:history true
                       :store_selection_keys :<TAB>
                       :updateevents "TextChanged,TextChangedI"
                       :delete_check_events "TextChanged,InsertLeave"})

(local from_vscode (require :luasnip.loaders.from_vscode))
(from_vscode.lazy_load)
(each [_ lang (pairs [:ruby :fennel])]
  (luasnip.add_snippets lang (require (.. :snippets. lang)) {:key lang}))
