(require :plenary)

(local functions (require :modules.functions))
(functions.setup :neogit
                 {:disable_signs false
                  :disable_hint false
                  :disable_context_highlighting false
                  :disable_commit_confirmation false
                  :auto_refresh true
                  :commit_popup {:kind :split}
                  :signs {:section [">" :v] :item [">" :v] :hunk ["" ""]}
                  :integrations {:diffview true}
                  :sections {:untracked {:folded false}
                             :unstaged {:folded false}
                             :staged {:folded false}
                             :stashes {:folded true}
                             :unpulled {:folded false}
                             :unmerged {:folded false}
                             :recent {:folded true}}
                  :mappings {:status {:B :BranchPopup}}})
