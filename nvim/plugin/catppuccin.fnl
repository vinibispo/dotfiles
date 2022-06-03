(local catppuccin (require :catppuccin))
(local config {:transparent_background false
               :term_colors true
               :integrations {:treesitter true
                              :native_lsp {:enabled true
                                           :virtual_text {:errors :italic
                                                          :hints :italic
                                                          :warnings :italic
                                                          :information :italic}
                                           :underlines {:errors :underline
                                                        :hints :underline
                                                        :warnings :underline
                                                        :information :underline}}
                              :lsp_trouble true
                              :cmp true
                              :lsp_saga true
                              :gitsigns true
                              :telescope true
                              :nvimtree {:enabled true
                                         :show_root false
                                         :transparent_panel false}
                              :neogit true
                              :bufferline true
                              :notify true}})

(catppuccin.setup config)
