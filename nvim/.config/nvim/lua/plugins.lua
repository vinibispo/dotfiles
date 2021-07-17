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

-- load plugins
return require("packer").startup(function(use)
  use {"wbthomason/packer.nvim"}

  -- colorscheme
  use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- my plugin
  use {
    "~/Documents/ViniBispo/ruby.nvim",
    requires = 'nvim-lua/plenary.nvim',
    ft = {'ruby'},
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
    end,
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end,
  }

  use {'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'}}

  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup {
        -- your personnal icons can go here (to override)
        -- DevIcon will be appended to `name`
        override = {zsh = {icon = "", color = "#428850", name = "Zsh"}},
        -- globally enable default icons (default to false)
        -- will get overriden by `get_icons` option
        default = true,
      }
    end,
  }

  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require'lualine'.setup {theme = 'onedark'}
    end,
  }

  -- language syntax highlight and small motions
  use {
    "nvim-treesitter/nvim-treesitter",
    run = "TSUpdate",
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "python",
          "lua",
          "yaml",
          "json",
          "javascript",
          "bash",
          "typescript",
          "ruby",
        },
        highlight = {enable = true, disable = {}},
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<leader>is",
            node_incremental = "+",
            scope_incremental = "w",
            node_decremental = "-",
          },
        },

        indent = {enable = true},
      }
    end,
  }

  -- code formatter
  use {
    "mhartington/formatter.nvim",
    config = function()
      require("modules.formatter")
    end,
  }

  -- lsp, completion, linting and snippets
  use {"kabouzeid/nvim-lspinstall"}
  use {"rafamadriz/friendly-snippets"}
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("modules.lsp")
    end,
    requires = {
      "glepnir/lspsaga.nvim",
      "hrsh7th/nvim-compe",
      "hrsh7th/nvim-compe",
      "hrsh7th/vim-vsnip",
      "hrsh7th/vim-vsnip-integ",
    },
  }

  -- bufferline tabs
  use {
    "akinsho/nvim-bufferline.lua",
    config = function()
      require("bufferline").setup({options = {numbers = "buffer_id"}})
    end,
  }
end)
