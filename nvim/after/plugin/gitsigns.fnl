(local gitsigns (require :gitsigns))
(gitsigns.setup {:signcolumn true
                 :current_line_blame_formatter "<author>, <author_time:%Y-%m-%d> - <summary>"})
