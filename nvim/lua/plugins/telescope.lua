local opts = {noremap = true}
local mapping = {
  {"n", ";", [[<Cmd>Telescope find_files<CR>]], opts},
  {"n", "<C-F>", [[<Cmd>Telescope live_grep<CR>]], opts},
  {"n", "<leader>g", [[<Cmd>Telescope git_files<CR>]], opts},
  {"n", "<leader>G", [[<Cmd>Telescope git_status<CR>]], opts},
  {"n", "<leader>b", [[<Cmd>Telescope buffers<CR>]], opts},
  {"n", "<leader>gb", [[<Cmd>Telescope git_branches<CR>]], opts},
}
for _, val in pairs(mapping) do
  vim.api.nvim_set_keymap(unpack(val))
end

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {horizontal = {mirror = false}, vertical = {mirror = false}},
    file_sorter = require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
  },
}
