local packer_exists = pcall(vim.cmd, [[ packadd packer.nvim ]])
if not packer_exists then
  local dest = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))
  local repo_url = string.format("https://github.com/wbthomason/packer.nvim")

  vim.fn.mkdir(dest, "p")

  print("Downloading packer")
  vim.fn.system(string.format("git clone %s %s", repo_url, dest .. "packer.nvim"))
  vim.cmd([[packadd packer.nvim]])
  vim.cmd("PackerSync")
  print("packer.nvim installed")
end
vim.cmd([[ autocmd BufWritePost plugins.lua PackerCompile ]])
return require("packer").startup(function(use)
  use {"wbthomason/packer.nvim"}

  -- emmet
  use {'mattn/emmet-vim'}

  -- editorconfig
  use {'gpanders/editorconfig.nvim'}

  use {'shaunsingh/nord.nvim'}

  -- commentary
  use {
    'b3nj5m1n/kommentary',
    config = function()

      require('kommentary.config').use_extended_mappings()
    end,
  }

  -- todo
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end,
  }

  -- yaml
  use {
    'cuducos/yaml.nvim',
    ft = {'yaml'},
    requires = {'nvim-treesitter/nvim-treesitter', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('yaml_nvim').init()
    end,
  }

  -- git
  use {
    "vinibispo/neogit",
    requires = {
      -- "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
    },
    branch = 'dev',
    config = function()
      require('plugins.neogit')
    end,
  }

  -- ruby
  use {
    'vinibispo/ruby.nvim',
    ft = {'ruby'},
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('ruby_nvim').setup({test_cmd = 'ruby', test_args = {}})
    end,
  }
  -- color
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require('colorizer').setup()
    end,
  }

  -- search, grep
  use {
    "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim"},
    config = function()
      require('plugins.telescope')
    end,
  }
  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.nvim-web-devicons')
    end,
  }
  use {
    'shadmansaleh/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require'lualine'.setup {theme = 'nord'}
    end,
  }

  -- language syntax highlighting
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require('plugins.nvim-treesiter')
    end,
  }
  use {
    'mhartington/formatter.nvim',
    config = function()
      require('modules.formatter')
    end,
  }

  -- lsp, completion, linting and snippets

  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("modules.lsp")
    end,
    requires = {"kabouzeid/nvim-lspinstall"},
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      'hrsh7th/vim-vsnip',
      "ray-x/cmp-treesitter",
    },

    config = function()
      require('plugins.cmp')
    end,
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  }

  use {"glepnir/lspsaga.nvim"}
  use {'kabouzeid/nvim-lspinstall', requires = {'neovim/nvim-lspconfig'}}
  use {"rafamadriz/friendly-snippets"}
  use {
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("bufferline").setup({options = {numbers = "buffer_id"}})
    end,
  }

end)
