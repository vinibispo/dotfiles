local telescope = require("telescope")
local builtin = require("telescope.builtin")
local previewer = require("telescope.previewers")
local sorters = require("telescope.sorters")
local helpers = require("modules.helpers")
local function project_files()
  if helpers.is_acg() then
    builtin.find_files({})
    return
  end
  local ok = pcall(builtin.git_files, { show_untracked = true })
  if not ok then
    builtin.find_files({})
  end
end

local function set_mapping()
  local opts = { noremap = true }
  local mappings = {
    { "n", "<leader>lg", builtin.live_grep, opts },
    { "n", "<leader>gf", builtin.git_files, opts },
    { "n", "<leader>pf", project_files, opts },
    { "n", "<leader>G", builtin.git_status },
    { "n", "<leader>b", builtin.buffers, opts },
    { "n", "<leader>gb", builtin.git_branches, opts },
  }
  for _, val in pairs(mappings) do
    local first = val[1]
    local second = val[2]
    local third = val[3]
    local fourth = val[4]
    vim.keymap.set(first, second, third, fourth)
  end
end

local function setup()
  telescope.setup({
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "> ",
      selection_caret = "> ",
      entry_prefix = " ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = { horizontal = { mirror = false }, vertical = { mirror = false } },
      file_sorter = sorters.get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter = sorters.get_generic_fuzzy_sorter,
      winblend = 0,
      border = {},
      color_devicons = true,
      use_less = true,
      path_display = {},
      file_previewer = previewer.vim_buffer_cat.new,
      grep_previewer = previewer.vim_buffer_vimgrep.new,
      qflist_previewer = previewer.vim_buffer_qflist.new,
    },
  })
end

setup()
set_mapping()
