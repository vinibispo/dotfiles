(require-macros :hibiscus.vim)
(augroup! :line_numbers [[BufEnter FocusGained InsertEnter InsertLeave]
                         *
                         #(set! relativenumber)]
          [[BufLeave FocusLost] * #(set! relativenumber false)])

(augroup! :jbuilder [[BufEnter] json.jbuilder "set filetype=ruby"])

(augroup! :packer [[BufWritePost] plugins.lua :PackerCompile])

(fn format-fennel []
  (when (= 1 (vim.fn.executable :fnlfmt))
    (exec [[":silent !fnlfmt --fix %"]])))

(fn source-file []
  (let [file-name (vim.fn.expand "%:r")
        config-folder (vim.fn.stdpath :config)
        lua-file (.. config-folder "/" (vim.fn.expand "%:p:.:gs?fnl?lua?"))
        source-file (if (= file-name :init)
                        (.. config-folder :/lua/tangerine_vimrc.lua)
                        lua-file)]
    (exec [[":source " source-file]])
    (print (.. "sourced: " source-file))))

(augroup! :_config [[BufWritePost] *.fnl `source-file]
          [[BufWritePost] *.fnl `format-fennel])
