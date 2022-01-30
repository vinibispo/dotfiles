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
    "cuducos/yaml.nvim",
    ft = {"yaml"}, -- optional
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("yaml_nvim").init()
    end,
  }

  -- git
  use {
    "TimUntersberger/neogit",
    requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
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
  use {
    'kyazdani42/nvim-tree.lua',
    config = function()
      require('plugins.nvim-tree')
    end,
    requires = {'kyazdani42/nvim-web-devicons'},
  }

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require('plugins.nvim-web-devicons')
    end,
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require'lualine'.setup {theme = 'nord'}
    end,
  }

  use {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      dap.adapters.ruby = {
        type = 'executable',
        command = 'bundle',
        args = {'exec', 'readapt', 'stdio'},
      }
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
    requires = {"williamboman/nvim-lsp-installer"},
  }
  use {
    "hrsh7th/nvim-cmp",
    requires = {
      "f3fora/cmp-spell",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        config = function()
          require('plugins.luasnip')
        end,
      },
      "ray-x/cmp-treesitter",
      'onsails/lspkind-nvim',
    },

    config = function()
      require('plugins.cmp')
    end,
  }
  --[[ use {
    'windwp/nvim-autopairs',
    config = function()
      -- you need setup cmp first put this after cmp.setup()
      require("nvim-autopairs.completion.cmp").setup({
        map_cr = true, --  map <CR> on insert mode
        map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
        auto_select = true, -- automatically select the first item
        insert = false, -- use insert confirm behavior instead of replace
        map_char = { -- modifies the function or method delimiter by filetypes
          all = '(',
          tex = '{',
        },
      })
    end,
  } ]]

  use {"tami5/lspsaga.nvim", branch = 'nvim51'}
  use {'williamboman/nvim-lsp-installer', requires = {'neovim/nvim-lspconfig'}}
  use {"rafamadriz/friendly-snippets"}
  use {
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("bufferline").setup({options = {numbers = "buffer_id"}})
    end,
  }

end)
