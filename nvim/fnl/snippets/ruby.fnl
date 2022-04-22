(local luasnip (require :luasnip))
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

(fn create-snip-ruby-minitest [class]
  (var str nil)
  (when (= class :ApplicationSystemTestCase)
    (set str :application_system_test_case))
  (snip {:trig :clat :name class}
        [(add-test-helper str) (create-test-class class)]))

[(create-snip-ruby-minitest "ActiveSupport::TestCase")
 (create-snip-ruby-minitest :ApplicationSystemTestCase)
 (create-snip-ruby-minitest "ActionDispatch::IntegrationTest")
 (create-snip-ruby-minitest "ActionMailer::TestCase")
 (create-snip-ruby-minitest "ActionMailer::TestCase")
 (create-snip-ruby-minitest "ActionView::TestCase")
 (create-snip-ruby-minitest "ActiveJob::TestCase")
 (create-snip-ruby-minitest "Rails::Generators::TestCase")
 (snip {:trig :setup :name :setup} [(create_block :setup)])
 (snip {:trig :tear :name :teardown} [(create_block :teardown)])
 (snip {:trig :as :name "assert(..)"} [(text "assert ") (insert 1 :test)])]
