(local luasnip (require :luasnip))
(luasnip.filetype_extend :ruby [:rails])
(luasnip.config.setup {:history true
                       :store_selection_keys :<TAB>
                       :updateevents "TextChanged,TextChangedI"
                       :delete_check_events "TextChanged,InsertLeave"})

(local {:snippet snip
        :snippet_node node
        :text_node text
        :insert_node insert
        :choice_node choice
        :dynamic_node dynamic} luasnip)

(fn before [snippet]
  (snippet.env.TM_CURRENT_LINE:match (.. "^(.*)" (. snippet.dscr 1)) 1))

(fn split [str sep]
  (local [new_sep fields] [(or sep ":") {}])
  (local pattern (string.format "([^%s]+)" new_sep))
  (str:gsub pattern
            (fn [c]
              (tset fields (+ (length fields) 1) c)))
  fields)

(fn convert_snake_case_in_pascal_case [str]
  (local new_str (or str ""))
  (local words [])
  (each [i v (pairs (split new_str "_"))]
    (local first_letter (v:sub 1 1))
    (table.insert words (.. (first_letter:upper) (v:sub 2))))
  (table.concat words ""))

(fn get_file_without_extension []
  (local path (vim.fn.expand "%"))
  (path:match "(.+)%..+"))

(fn create_test_class [inherit_from]
  (text ["" "" "class "])
  (insert [1 (convert_snake_case_in_pascal_case (get_file_without_extension))])
  (text [(.. " < " inherit_from) ""])
  (text [" "])
  (insert [2 " "])
  (text ["" :end]))

(fn add_test_helper [str]
  (local new_str (or str ""))
  (if (= new_str "")
      (text "require 'test_helper'")
      (text (.. "require '" new_str "'"))))

(fn create_block [name]
  (text (.. name " do"))
  (text ["" " "])
  (insert 0 "")
  (text ["" :end]))

; (tset luasnip.snippets :ruby [])

(local from_vscode (require :luasnip/loaders/from_vscode))
(from_vscode.lazy_load)
