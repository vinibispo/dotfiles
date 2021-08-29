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

  -- rest
  use {
    'NTBBloodbath/rest.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()
      require('rest-nvim').setup({
        result_split_horizontal = false,
        skip_ssl_verification = true,
      })
    end,
  }
  -- editorconfig
  use {'gpanders/editorconfig.nvim'}
  -- colorscheme
  use {'shaunsingh/nord.nvim'}
  use {
    "cuducos/yaml.nvim",
    ft = {'yaml'},
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("yaml_nvim").init()
    end,
  }
  -- discord
  use {
    'andweeb/presence.nvim',
    config = function()
      -- The setup config table shows all available config options with their default values:
      require("presence"):setup({
        -- General options
        auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
        neovim_image_text = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
        main_image = "neovim", -- Main image display (either "neovim" or "file")
        client_id = "869658277355589703", -- Use your own Discord application client id (not recommended)
        log_level = nil, -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
        debounce_timeout = 10, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
        enable_line_number = false, -- Displays the current line number instead of the current project

        -- Rich Presence text options
        editing_text = "Editing %s", -- Format string rendered when an editable file is loaded in the buffer
        file_explorer_text = "Browsing %s", -- Format string rendered when browsing a file explorer
        git_commit_text = "Committing changes", -- Format string rendered when commiting changes in git
        plugin_manager_text = "Managing plugins", -- Format string rendered when managing plugins
        reading_text = "Reading %s", -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer
        workspace_text = "Working on %s", -- Workspace format string (either string or function(git_project_name: string|nil, buffer: string): string)
        line_number_text = "Line %s out of %s", -- Line number format string (for when enable_line_number is set to true)
      })
    end,
  }
  -- git

  use {
    'TimUntersberger/neogit',
    requires = {'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim'},
    config = function()
      require('plugins.neogit')
    end,
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = function()

      require('gitsigns').setup {
        signs = {
          add = {
            hl = 'GitSignsAdd',
            text = '│',
            numhl = 'GitSignsAddNr',
            linehl = 'GitSignsAddLn',
          },
          change = {
            hl = 'GitSignsChange',
            text = '│',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
          },
          delete = {
            hl = 'GitSignsDelete',
            text = '_',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
          },
          topdelete = {
            hl = 'GitSignsDelete',
            text = '‾',
            numhl = 'GitSignsDeleteNr',
            linehl = 'GitSignsDeleteLn',
          },
          changedelete = {
            hl = 'GitSignsChange',
            text = '~',
            numhl = 'GitSignsChangeNr',
            linehl = 'GitSignsChangeLn',
          },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        keymaps = {
          -- Default keymap options
          noremap = true,

          ['n ]c'] = {
            expr = true,
            "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'",
          },
          ['n [c'] = {
            expr = true,
            "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'",
          },

          ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
          ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
          ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
          ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
          ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
          ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
          ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
          ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
          ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

          -- Text objects
          ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
          ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
        },
        watch_index = {interval = 1000, follow_files = true},
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
        },
        current_line_blame_formatter_opts = {relative_time = false},
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = 'single',
          style = 'minimal',
          relative = 'cursor',
          row = 0,
          col = 1,
        },
        use_internal_diff = true, -- If vim.diff or luajit is present
        yadm = {enable = false},
      }
    end,
  }

  -- my plugin
  use {
    'vinibispo/ruby.nvim',
    ft = {'ruby'}, -- optional
    requires = {'nvim-lua/plenary.nvim'},
    config = function() -- optional
      require("ruby_nvim").setup({
        test_cmd = "ruby", -- the default value
        test_args = {}, -- the default value
      })
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
      require'lualine'.setup {theme = 'nord'}
    end,
  }

  -- language syntax highlight and small motions
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
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
