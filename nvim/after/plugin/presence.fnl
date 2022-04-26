(local presence (require :presence))
(presence:setup {:auto_update true
                 :neovim_image_text "The One True Text Editor"
                 :main_image :neovim
                 :client_id :793271441293967371
                 :log_level :error
                 :debounce_timeout 10
                 :enable_line_number false
                 :blacklist []
                 :buttons true
                 :file_assets []
                 :editing_text "Editing %s"
                 :file_explorer_text "Browsing %s"
                 :git_commit_text "Commiting changes"
                 :plugin_manager_text "Managing plugins"
                 :reading_text "Reading %s"
                 :workspace_text "Working on %s"
                 :line_number_text "Line %s out of %s"})
