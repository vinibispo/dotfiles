vim.opt.termguicolors = true
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Plugin Manager
  use 'mattn/emmet-vim' -- Emmet
  use { 'catppuccin/nvim', as = 'catppuccin' } -- Colorscheme
  use { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup()
  end } -- Comment
  use { 'TimUntersberger/neogit', requires = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim' } } -- Git general
  use { 'vinibispo/ruby.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' } } -- Ruby general

  use { 'cuducos/yaml.nvim', requires = { 'nvim-treesitter/nvim-treesitter', 'nvim-telescope/telescope.nvim' } } -- Yaml navigation

  use {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    }
  } -- File explorer
  use { 'norcalli/nvim-colorizer.lua', config = function()
    require('colorizer').setup({ "*", css = { hsl_fn = true }, scss = { hsl_fn = true } })
  end } -- Colors

  use { "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim", "nvim-lua/popup.nvim", "nvim-telescope/telescope-dap.nvim" } } -- Fuzzy Finder
  use 'kyazdani42/nvim-web-devicons' -- Icons
  use { "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } } -- Status Line
  use 'mfussenegger/nvim-dap'
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" } -- TreeSitter Support
  use 'nvim-treesitter/playground' -- TreeSitter Debug
  use { "neovim/nvim-lspconfig", requires = { 'williamboman/mason.nvim', 'williamboman/mason-lspconfig.nvim' } } -- Neovim LSP Config
  use { "hrsh7th/nvim-cmp",
    requires = { "f3fora/cmp-spell", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path", "saadparwaiz1/cmp_luasnip", "L3MoN4D3/LuaSnip", "ray-x/cmp-treesitter", "onsails/lspkind-nvim",
      "rafamandriz/friendly-snippets" } } -- Auto Completion
  use { "akinsho/bufferline.nvim", config = function()
    vim.schedule(function()
      require('bufferline').setup {}
    end)
  end } -- Bufferline (Tabs)
  use { "folke/trouble.nvim", config = function()
    require('trouble').setup()
  end } -- LSP Diagnostic List
  use { "jose-elias-alvarez/null-ls.nvim", requires = "nvim-lua/plenary.nvim" } -- Add LSP stuff in linters
  use { "j-hui/fidget.nvim", config = function()
    require('fidget').setup {}
  end } -- LSP Progress Spinner

  use { "folke/todo-comments.nvim", config = function()
    require('todo-comments').setup()
  end } -- TODO, NOTE, FIX list
  use 'rcarriga/nvim-notify' -- Notifications of Neovim

  use 'glepnir/lspsaga.nvim'

end)
