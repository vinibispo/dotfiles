require("bufferline").setup({
  options = {
    mode = "tabs",
    groups = {
      options = {
        toggle_hidden_on_enter = true, -- when you re-enter a hidden group this options re-opens that group so the buffer is visible
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            separator = true -- use a "true" to enable the default, or set your own character
          }
        }
      },
      items = {
        {
          name = "Tests", -- Mandatory
          highlight = { underline = true, sp = "blue" }, -- Optional
          priority = 2, -- determines where it will appear relative to other groups (Optional)
          icon = "", -- Optional
          matcher = function(buf) -- Mandatory
            return buf.filename:match('%_test') or buf.filename:match('%_spec')
          end,
        },
        {
          name = "Docs",
          highlight = { undercurl = true, sp = "green" },
          auto_close = false, -- whether or not close this group if it doesn't contain the current buffer
          matcher = function(buf)
            return buf.filename:match('%.md') or buf.filename:match('%.txt')
          end,
          separator = { -- Optional
            style = require('bufferline.groups').separator.tab
          },
        }
      }
    }
  },
})
