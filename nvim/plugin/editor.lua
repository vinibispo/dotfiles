local function set_globals()
	vim.g.mapleader = ","
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
    foldmethod = "expr",
    foldexpr = "nvim_treesitter#foldexpr()",
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
    termguicolors = true
  }
  for key, val in pairs(options) do
    vim.opt[key] = val
  end
end

local function set_theme()
  vim.g.catppuccin_flavour = "latte"
	vim.cmd([[ colorscheme catppuccin]])
end

set_globals()

set_options()

set_theme()
