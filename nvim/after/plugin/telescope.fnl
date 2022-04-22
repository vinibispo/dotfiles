(local functions (require :modules.functions))
(local builtin (require :telescope.builtin))
(local previewer (require :telescope.previewers))
(local sorters (require :telescope.sorters))
(fn project_files []
  (let [opts {}
        ok (pcall builtin.git_files opts)]
    (when (not ok)
      (builtin.find_files opts))))

(fn set_mapping []
  (let [opts {:noremap true}
        mapping [[:n :<C-f> #(builtin.live_grep) opts]
                 [:n :<leader>g #(builtin.git_files) opts]
                 [:n ";" #(project_files) opts]
                 [:n :<leader>G #(builtin.git_status)]
                 [:n :<leader>b #(builtin.buffers) opts]
                 [:n :<leader>gb #(builtin.git_branches) opts]]]
    (each [key val (pairs mapping)]
      (let [[first second third fourth] val]
        (vim.keymap.set first second third fourth)))))

(fn setup []
  (functions.setup :telescope
                   {:defaults {:vimgrep_arguments [:rg
                                                   :--color=never
                                                   :--no-heading
                                                   :--with-filename
                                                   :--line-number
                                                   :--column
                                                   :--smart-case]
                               :prompt_prefix "> "
                               :selection_caret "> "
                               :entry_prefix "  "
                               :initial_mode :insert
                               :selection_strategy :reset
                               :sorting_strategy :descending
                               :layout_strategy :horizontal
                               :layout_config {:horizontal {:mirror false}
                                               :vertical {:mirror false}}
                               :file_sorter sorters.get_fuzzy_file
                               :file_ignore_patterns {}
                               :generic_sorter sorters.get_generic_fuzzy_sorter
                               :winblend 0
                               :border {}
                               :borderchars ["─"
                                             "│"
                                             "─"
                                             "│"
                                             "╭"
                                             "╮"
                                             "╯"
                                             "╰"]
                               :color_devicons true
                               :use_less true
                               :path_display {}
                               :set_env [[:COLORTERM] :truecolor]
                               :file_previewer previewer.vim_buffer_cat.new
                               :grep_previewer previewer.vim_buffer_vimgrep.new
                               :qflist_previewer previewer.vim_buffer_qflist.new}}))

(set_mapping)
(setup)
