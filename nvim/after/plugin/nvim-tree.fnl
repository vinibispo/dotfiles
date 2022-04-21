(require-macros :hibiscus.vim)
(local nvim_tree (require :nvim-tree))
(local {: setup} (require :modules.functions))
(fn set_setup []
  (setup :nvim-tree
         {:disable_netrw true
          :filters {:dotfiles true}
          :hijack_netrw true
          :open_on_setup false
          :auto_close false
          :open_on_tab false
          :git {:ignore true}
          :update_to_buf_dir {:enable true :auto_open true}
          :hijack_cursor false
          :update_cwd false
          :diagnostics {:enable true}
          :update_focused_file {:enable true
                                :update_cwd :false
                                :ignore_list [:.git :node_modules :.cache]}
          :system_open {:cmd nil :args {}}
          :view {:width 30
                 :height 30
                 :side :left
                 :auto_resize false
                 :mappings {:custom_only false :list {}}}}))

(fn set_mappings []
  (local mappings [[:n :<leader>t #(nvim_tree.toggle false) {:noremap true}]])
  (each [keys val (pairs mappings)]
    (let [[first second third fourth] val]
      (vim.keymap.set first second third fourth))))

(fn set_globals []
  (g! :nvim_tree_git_hl 1)
  (g! :nvim_tree_highlight_opened_files 1)
  (g! :nvim_tree_add_trailing 1))

(set_setup)
(set_mappings)
(set_globals)
