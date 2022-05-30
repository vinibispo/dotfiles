(local cmp (require :cmp))
(local lspkind (require :lspkind))
(local luasnip (require :luasnip))
(fn has_words_before []
  (local [line col] (vim.api.nvim_win_get_cursor 0))
  (local has (and (not= 0 col)
                  (= nil (: (: (. (vim.api.nvim_buf_get_lines 0 (- line 1) line
                                                              true)
                                  1) :sub col
                               col) :match "%s"))))
  has)

(cmp.setup {:snippet {:expand (fn [args]
                                (luasnip.lsp_expand args.body))}
            :formatting {:format (lspkind.cmp_format {:width_text false
                                                      :max_width 50
                                                      :menu {:buffer "[Buffer]"
                                                             :nvim_lsp "[LSP]"
                                                             :luasnip "[LuaSnip]"
                                                             :nvim_lua "[Lua]"}})}
            :mapping {:<Tab> (cmp.mapping (fn [fallback]
                                            (if (cmp.visible)
                                                (cmp.select_next_item)
                                                (luasnip.expand_or_jumpable)
                                                (luasnip.expand_or_jump)
                                                (has_words_before)
                                                (cmp.complete)
                                                (fallback)))
                                          [:i :s])
                      :<S-Tab> (cmp.mapping (fn [fallback]
                                              (if (cmp.visible)
                                                  (cmp.mapping.select_prev_item)
                                                  (luasnip.jumpable -1)
                                                  (luasnip.jump -1)
                                                  (fallback)))
                                            [:i :s])
                      :<C-Space> (cmp.mapping.complete)
                      :<C-e> (cmp.mapping.close)
                      :<CR> (cmp.mapping.confirm {:behavior cmp.ConfirmBehavior.Insert
                                                  :select true})}
            ; :mapping (cmp.mapping.preset.insert {:<Tab> (cmp.mapping (fn [fallback]
            ;                                                            (if (cmp.visible)
            ;                                                                (cmp.mapping.select_next_item)
            ;                                                                (luasnip.expand_or_jumpable)
            ;                                                                (luasnip.expand_or_jump)
            ;                                                                (has_words_before)
            ;                                                                (cmp.mapping.complete)
            ;                                                                (fallback))))
            ;                                      :<S-Tab> (cmp.mapping (fn [fallback]
            ;                                                              (if (cmp.visible)
            ;                                                                  (cmp.mapping.select_prev_item)
            ;                                                                  (luasnip.jumpable -1)
            ;                                                                  (luasnip.jump -1)
            ;                                                                  (fallback))))})
            :sources [{:name :buffer}
                      {:name :nvim_lsp}
                      {:name :nvim_lua}
                      {:name :path}
                      {:name :spell}
                      {:name :treesitter}
                      {:name :greek}
                      {:name :luasnip}]})
