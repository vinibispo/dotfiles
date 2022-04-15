local api = vim.api
local opt = vim.opt
local g = vim.g
local cmd = vim.cmd

local function set_globals()
  g.mapleader = ','
  g.vimspector_enable_mappings = 'HUMAN'
end
local function tableMerge(t1, t2)
  for k,v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        tableMerge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
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
  cmd([[
    autocmd BufEnter *.json.jbuilder set filetype=ruby
  ]])

  cmd([[
    autocmd BufEnter .env.* set filetype=sh  ]])
  cmd([[
    autocmd BufEnter Dockerfile.* set filetype=dockerfile ]])
end

local function set_mapping()
  local opts = {noremap = true}
  local mappings = {
    {"i", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts},
    {"s", "<c-j>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts},
    {"i", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts},
    {"s", "<c-k>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts},
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
    {"n", "<leader>ev", "<Cmd>e ~/dotfiles/nvim/init.lua<CR>", opts},
    -- source main lua file
    {"n", "<leader>sv", "<Cmd>luafile ~/dotfiles/nvim/init.lua<CR>", opts},
    -- save when use S
    {"n", "S", "<Cmd>w<CR>", opts},
    -- quit when use Q
    {"n", "Q", "<Cmd>q<CR>", opts},
    {"v", "<leader>cn", "<Cmd>CarbonNow<CR>", {noremap = true, silent = true}},
    -- disable arrows
    -- {"n", "<left>", "<nop>", opts},
    -- {"n", "<right>", "<nop>", opts},
    -- {"i", "<left>", "<nop>", opts},
    -- {"i", "<right>", "<nop>", opts},
    -- stop c, s and d from yanking
    {"n", ";", [[<Cmd>lua require 'plugins.telescope'.project_files()<CR>]], opts},
    {"n", "<leader>t", "<Cmd>NvimTreeToggle<CR>", opts},
    {"n", "c", [["_c]], opts},
    {"x", "c", [["_c]], opts},
    {"n", "d", [["_d]], opts},
    {"x", "d", [["_d]], opts},
    -- stop p from overwtitting the register (by re-yanking it)
    {"x", "p", "pgvy", opts},
    {"n", "p", "p=`]", opts},
    {"n", "P", "P=`]", opts},
    {"n", "<F5>", [[<Cmd>lua require 'dap'.continue()<CR>]], tableMerge(opts, {silent = true })},
  {"n", "<F10>", [[<Cmd>lua require 'dap'.step_over()<CR>]], tableMerge(opts, {silent = true })},
  {"n", "<F11>", [[<Cmd>lua require 'dap'.step_into()<CR>]], tableMerge(opts, {silent = true })},
  {"n", "<F12>", [[<Cmd>lua require 'dap'.step_out()<CR>]], tableMerge(opts, {silent = true })},
  {"n", "<F7>", [[<Cmd>lua require 'dap'.toggle_breakpoint()<CR>]], tableMerge(opts, {silent = true })},
  {"n", "<leader>B", [[<Cmd>lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>]], tableMerge(opts, {silent = true })},
  {"n", "<leader>lp", [[<Cmd>lua require 'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>]], tableMerge(opts, {silent = true })},
  {"n", "<leader>dr", [[<Cmd>lua require 'dap'.repl.open()<CR>]], tableMerge(opts, {silent = true })},
  {"n", "<leader>dl", [[<Cmd>lua require 'dap'.run_last()<CR>]], tableMerge(opts, {silent = true })}
  }

  for _, val in pairs(mappings) do
    api.nvim_set_keymap(unpack(val))
  end
end

local function set_theme()
  cmd([[colorscheme nord]])
end

set_options()
set_globals()
set_mapping()
set_theme()
