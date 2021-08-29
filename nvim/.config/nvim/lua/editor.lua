-- main editor configs
local api = vim.api
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

local function set_globals()
  g.ruby_host_prog = "~/.asdf/shims/neovim-ruby-host"
  g.coc_node_path = "~/.asdf/installs/nodejs/12.15.0/bin/node"
  g.mapleader = ","
  g.nvim_tree_width = 40
  g.nvim_tree_ignore = {'.git', 'node_modules', '.cache'}
  g.nvim_tree_gitignore = 1
  g.nvim_tree_auto_open = 1
  g.nvim_tree_auto_close = 1
  g.nvim_tree_quit_on_open = 1
  g.nvim_tree_follow = 1
  g.nvim_tree_indent_markers = 1
  g.nvim_tree_hide_dotfiles = 1
  g.nvim_tree_git_hl = 1
  g.nvim_tree_highlight_opened_files = 1
  g.nvim_tree_root_folder_modifier = ':~'
  g.nvim_tree_tab_open = 1
  g.nvim_tree_auto_resize = 0
  g.nvim_tree_add_trailing = 1
  g.nvim_tree_group_empty = 1
  g.nvim_tree_lsp_diagnostics = 1
  g.nvim_tree_disable_window_picker = 1
  g.nvim_tree_icon_padding = ' '
  g.nvim_tree_update_cwd = 1
end

local function set_options()

  local undo_dir = os.getenv("HOME") .. '/.local/share/nvim/undo'
  local options = {
    incsearch = true,
    ignorecase = true,
    encoding = "UTF-8",
    ffs = 'unix,dos,mac',
    modeline = true,
    autoindent = true,
    tabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    smarttab = true,
    backspace = 'indent,eol,start',
    laststatus = 2,
    relativenumber = true,
    vb = true,
    confirm = true,
    showmode = false,
    smartindent = true,
    clipboard = 'unnamed,unnamedplus',
    wrap = true,
    linebreak = true,
    foldmethod = "indent",
    foldnestmax = 3,
    wildmode = "list:longest",
    wildmenu = true,
    wildignore = "*.o, *.obj, *~, *vim/backups, *sass-cache, *DS_Store, vendor/rails/**, vendor/cache/**, *.gem, log/**, tmp/**, *.png, *.jpg, *.gif, *.swp, *.pyc",
    scrolloff = 8,
    sidescrolloff = 1,
    sidescroll = 1,
    modifiable = true,
    foldlevelstart = 99,
    exrc = true,
    guicursor = '',
    hidden = true,
    number = true,
    undodir = undo_dir,
    undofile = true,
    completeopt = "menuone,noinsert,noselect",
    signcolumn = "yes",
    cmdheight = 2,
    updatetime = 50,
    colorcolumn = "80",
    background = 'dark',
    termguicolors = true,
  }
  for key, val in pairs(options) do
    opt[key] = val
  end

  cmd("colorscheme nord")
  cmd([[
        augroup LineNumbers
            autocmd!
            autocmd InsertEnter * set relativenumber
            autocmd FocusGained * set relativenumber
            autocmd BufEnter * set relativenumber
            autocmd InsertLeave * set relativenumber
            autocmd FocusLost * set norelativenumber
        augroup END
        ]])
end

local function set_mapping()
  local opts = {noremap = true}
  local mappings = {
    {"n", "<F5>", "<Cmd>e!<CR>", opts},
    {"n", "<leader>W", "<Cmd>w<CR>", opts},
    -- go window up
    {"n", "<leader>w", "<Cmd>wincmd k<CR>", opts},
    -- go window down
    {"n", "<leader>s", "<Cmd>wincmd j<CR>", opts},
    -- go window left
    {"n", "<leader>a", "<Cmd>wincmd h<CR>", opts},
    -- go window down
    {"n", "<leader>d", "<Cmd>wincmd l<CR>", opts},
    -- open new vertical window
    {"n", "<leader>d", "<Cmd>vertical <Cmd>new<CR>", opts},
    -- open new horizontal window
    {"n", "<leader>h", "<Cmd>new<CR>", opts},
    -- quit current buffer
    {"n", "<leader>q", "<Cmd>q<CR>", opts},
    -- force quit current buffer
    {"n", "<leader>Q", "<Cmd>q!<CR>", opts},
    -- create a new tab
    {"n", "<leader>n", "<Cmd>tabnew<CR>", opts},
    -- move to previous tab
    {"n", "<leader>z", "<Cmd>tabprevious<CR>", opts},
    -- move to next tab
    {"n", "<leader>x", "<Cmd>tabnext<CR>", opts},
    -- edit main lua file
    {"n", "<leader>ev", "<Cmd>e ~/dotfiles/nvim/.config/nvim/init.lua<CR>", opts},
    -- source main lua file
    {"n", "<leader>sv", "<Cmd>luafile ~/dotfiles/nvim/.config/nvim/init.lua<CR>", opts},
    -- save when use S
    {"n", "S", "<Cmd>w<CR>", opts},
    -- quit when use Q
    {"n", "Q", "<Cmd>q<CR>", opts},
    -- disable arrows
    -- {"n", "<left>", "<nop>", opts},
    -- {"n", "<right>", "<nop>", opts},
    -- {"i", "<left>", "<nop>", opts},
    -- {"i", "<right>", "<nop>", opts},
    -- stop c, s and d from yanking
    {"n", "c", [["_c]], opts},
    {"x", "c", [["_c]], opts},
    {"n", "d", [["_d]], opts},
    {"x", "d", [["_d]], opts},
    -- stop p from overwtitting the register (by re-yanking it)
    {"x", "p", "pgvy", opts},
    -- toggle nvim_tree_lua
    {"n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", opts},
    -- auto indent pasted text
    {"n", "p", "p=`]", opts},
    {"n", "P", "P=`]", opts},
  }
  for _, val in pairs(mappings) do
    api.nvim_set_keymap(unpack(val))
  end
end

local function set_theme()
  g.nord_contrast = true
  g.nord_borders = false
  g.nord_disable_background = false
  require('nord').set()
end

set_globals()
set_options()
set_mapping()
set_theme()
