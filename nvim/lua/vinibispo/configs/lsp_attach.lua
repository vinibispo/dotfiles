local function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  if next(lines) == nil then
    return nil
  end
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return lines
end

local function open_window(filetype, server_opts)
  local selection = get_visual_selection()
  local width = vim.o.columns
  local height = vim.o.lines
  local height_ratio = 0.7
  local width_ratio = 0.7
  local win_height = math.ceil(height * height_ratio)
  local win_width = math.ceil(width * width_ratio)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  local win_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
  }

  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, win_opts)
  vim.api.nvim_win_set_option(win, "winblend", 0)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "filetype", filetype)
  vim.opt_local.modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, 0, false, selection)
  local new_server_opts = vim.tbl_extend("force", server_opts, { rooot_dir = vim.loop.cwd() })
  vim.lsp.start_client(new_server_opts)
end

local function get_installed_servers()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local mason_lspconfig = require("mason-lspconfig")
  local attach_mappings = function(prompt_bufnr, _)
    actions.select_default:replace(function()
      actions.close(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      local server = selection[1]
      local lsp = require("lspconfig")[server]
      local filetypes = lsp.filetypes
      local filetype
      if type(filetypes) == "table" then
        filetype = filetypes[1]
        if type(filetype) == "nil" then
          filetype = lsp.document_config.default_config.filetypes[1]
        end
      else
        filetype = lsp.document_config.default_config.filetypes[1]
      end
      open_window(filetype, lsp)
    end)
    return true
  end

  local finder = finders.new_table({ results = mason_lspconfig.get_installed_servers() })
  local picker = pickers.new(
    {},
    { prompt_title = "LSP Installed servers", finder = finder, attach_mappings = attach_mappings }
  )
  return picker:find()
end

vim.api.nvim_create_user_command("LspRangeAttach", function()
  get_installed_servers()
end, { range = true })

vim.api.nvim_create_user_command("LspRangeUnattach", function() end, {})
