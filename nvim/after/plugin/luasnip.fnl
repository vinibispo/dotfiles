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

(fn convert-snake-case-in-pascal-case [str]
  (local new_str (or str ""))
  (local words [])
  (each [i v (pairs (split new_str "_"))]
    (local first_letter (v:sub 1 1))
    (table.insert words (.. (first_letter:upper) (v:sub 2))))
  (table.concat words ""))

(fn get-file-without-extension []
  (local path (vim.fn.expand "%"))
  (local path_in_string (path:match "(.+)%..+"))
  (if (not (= path_in_string nil))
      (let [array []
            formatted (string.format "([^%s]+)" "/")]
        (each [value (string.gmatch path_in_string formatted)]
          (table.insert array value))
        (. array (length array)))
      ""))

(fn create-test-class [inherit_from]
  (values (text ["" "" "class "])
          (insert 1
                  (convert-snake-case-in-pascal-case (get-file-without-extension)))
          (text [(.. " < " inherit_from) ""]) (text " ") (insert 2 " ")
          (text ["" :end])))

(fn add-test-helper [str]
  (local new_str (or str ""))
  (if (= new_str "")
      (text "require 'test_helper'")
      (text (.. "require '" new_str "'"))))

(fn create_block [name]
  (values (text (.. name " do")) (text ["" " "]) (insert 0 "") (text ["" :end])))

; (luasnip.add_snippets :lua
;                       [(snip :func
;                              [(dynamic 1
;                                        (fn [_ snippet]
;                                          (local line (before snippet))
;                                          (if (= line "")
;                                              (node nil
;                                                    (choice 1
;                                                            [(text "local ")
;                                                             (text "")]))
;                                              (line:match "^%S*$")
;                                              (node nil
;                                                    (choice 1
;                                                            [(text "")
;                                                             (text "local ")]))
;                                              (node nil (text "")))))
;                               (text :function)
;                               (dynamic 2
;                                        (fn [args snippet]
;                                          (local snippet_before (before snippet))
;                                          (if (not (snippet_before:match "^%S*S"))
;                                              (node nil (text ""))
;                                              (not= (. (. args 1)) "local ")
;                                              (node nil
;                                                    [(choice 1
;                                                             [(text :M.)
;                                                              (text "")])
;                                                     (insert 2 :name)])
;                                              (node nil
;                                                    [(text " ")
;                                                     (insert 1 :name)])))
;                                        [1])
;                               (text "(")
;                               (insert 3 :param)
;                               (text [")" "\\t"])
;                               (dynamic 4
;                                        (fn [_ snippet]
;                                          (local vis
;                                                 (. snippet.env.TM_SELECTED_TEXT
;                                                    1))
;                                          (if vis
;                                              (node nil [(text vis) (insert 1)])
;                                              (insert 1 (or _G.placeholder ""))))
;                                        [])
;                               (text ["" :end])])])

(fn create-snip-ruby-minitest [class]
  (var str nil)
  (when (= class :ApplicationSystemTestCase)
    (set str :application_system_test_case))
  (snip {:trig :clat :name class}
        [(add-test-helper str) (create-test-class class)]))

(luasnip.add_snippets :ruby
                      [(create-snip-ruby-minitest "ActiveSupport::TestCase")
                       (create-snip-ruby-minitest :ApplicationSystemTestCase)
                       (create-snip-ruby-minitest "ActionDispatch::IntegrationTest")
                       (create-snip-ruby-minitest "ActionMailer::TestCase")
                       (create-snip-ruby-minitest "ActionMailer::TestCase")
                       (create-snip-ruby-minitest "ActionView::TestCase")
                       (create-snip-ruby-minitest "ActiveJob::TestCase")
                       (create-snip-ruby-minitest "Rails::Generators::TestCase")
                       (snip {:trig :setup :name :setup}
                             [(create_block :setup)])
                       (snip {:trig :tear :name :teardown}
                             [(create_block :teardown)])
                       (snip {:trig :as :name "assert(..)"}
                             [(text "assert ") (insert 1 :test)])])

; Later I add other snippets again

(local from_vscode (require :luasnip.loaders.from_vscode))
(from_vscode.lazy_load)
