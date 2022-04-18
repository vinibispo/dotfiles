-- hacked PackerRemove cmd
PackerReinstall =
    function(name) -- usage example => :lua PackerReinstall "yaml.nvim"
        if package.loaded["packer"] == nil then
            print("Packer not installed or not loaded")
        end

        local utils = require("packer.plugin_utils")
        local suffix = "/" .. name

        local opt, start = utils.list_installed_plugins()
        for _, group in pairs({opt, start}) do
            if group ~= nil then
                for dir, _ in pairs(group) do
                    if dir:sub(-string.len(suffix)) == suffix then
                        print("Removing", dir)
                        vim.cmd("!rm -rf " .. dir)
                        vim.cmd(":PackerSync")
                        return
                    end
                end
            end
        end
    end
local packer_exists = pcall(vim.cmd, [[ packadd packer.nvim ]])
if not packer_exists then
    local dest = string.format("%s/site/pack/packer/opt/",
                               vim.fn.stdpath("data"))
    local repo_url = string.format("https://github.com/wbthomason/packer.nvim")

    vim.fn.mkdir(dest, "p")

    print("Downloading packer")
    vim.fn.system(string.format("git clone %s %s", repo_url,
                                dest .. "packer.nvim"))
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
        end
    }

    -- todo
    --[[ use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    } ]]

    -- git
    use {
        "TimUntersberger/neogit",
        requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
        config = function() require('plugins.neogit') end
    }

    -- ruby
    use {
        'vinibispo/ruby.nvim',
        ft = {'ruby'},
        requires = {'nvim-lua/plenary.nvim'},
        config = function()
            require('ruby_nvim').setup({test_cmd = 'ruby', test_args = {}})
        end
    }
    -- color
    use {
        "norcalli/nvim-colorizer.lua",
        config = function() require('colorizer').setup() end
    }

    -- search, grep
    use {
        "nvim-telescope/telescope.nvim",
    requires = {"nvim-lua/plenary.nvim", "nvim-lua/popup.nvim", "nvim-telescope/telescope-dap.nvim"},
        config = function() require('plugins.telescope') end
    }
    use {
        'kyazdani42/nvim-tree.lua',
        config = function() require('plugins.nvim-tree') end,
        requires = {'kyazdani42/nvim-web-devicons'}
    }

    use {
        'kyazdani42/nvim-web-devicons',
        config = function() require('plugins.nvim-web-devicons') end
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true},
        config = function() require'lualine'.setup {theme = 'nord'} end
    }

    use {
        'mfussenegger/nvim-dap',
        config = function()
            local dap = require('dap')
dap.adapters.node2 = {
    type = 'executable',
    command = 'node',
    args = {
        vim.fn.stdpath("data") .. "/dapinstall/jsnode_dbg/" ..
            '/vscode-node-debug2/out/src/nodeDebug.js'
    }
}

dap.configurations.javascript = {
    {
        type = 'node2',
        request = 'launch',
        program = '${workspaceFolder}/${file}',
        cwd = vim.fn.getcwd(),
        sourceMaps = true,
        protocol = 'inspector',
        console = 'integratedTerminal'
    }
}
        end
    }

  use {'Pocco81/DAPInstall.nvim'}

    -- language syntax highlighting
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function() require('plugins.nvim-treesiter') end
    }
    -- lsp, completion, linting and snippets

    use {
        "neovim/nvim-lspconfig",
        config = function() require("modules.lsp") end,
        requires = {"williamboman/nvim-lsp-installer"}
    }
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "f3fora/cmp-spell", "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua", "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            {
                "L3MON4D3/LuaSnip",
                config = function() require('plugins.luasnip') end
            }, "ray-x/cmp-treesitter", 'onsails/lspkind-nvim'
        },

        config = function() require('plugins.cmp') end
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

    use {"tami5/lspsaga.nvim"}
    use {
        'williamboman/nvim-lsp-installer',
        requires = {'neovim/nvim-lspconfig'}
    }
    use {"rafamadriz/friendly-snippets"}
    use {'KabbAmine/zeavim.vim'}
    -- Lua
    use {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use {
        "akinsho/nvim-bufferline.lua",
        config = function()
            require("bufferline").setup({options = {numbers = "buffer_id"}})
        end
    }
    use {
        "ellisonleao/carbon-now.nvim",
        config = function() require('carbon-now').setup() end
    }

    -- use {'puremourning/vimspector'}
    use 'folke/lsp-colors.nvim'
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end
    }
    use {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
            require("null-ls").setup({
                -- you can reuse a shared lspconfig on_attach callback here
                sources = {
                    require("null-ls").builtins.formatting.eslint,
                    require("null-ls").builtins.diagnostics.rubocop,
                    -- require("null-ls").builtins.completion.spell,
                    require("null-ls").builtins.formatting.stylua.with({
condition = function(utils)
        return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
      end,
                    })
                },
                on_attach = function(client)
                    if client.resolved_capabilities.document_formatting then
                        vim.cmd([[
            augroup LspFormatting
                autocmd! * <buffer>
                autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
            augroup END
            ]])
                    end
                end
            })
        end
    }
  use { 'akinsho/toggleterm.nvim' }
  use 'propet/toggle-fullscreen.nvim'
  use { 'andweeb/presence.nvim', config = function ()
    -- The setup config table shows all available config options with their default values:
    require("presence"):setup({
      -- General options
      auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
      neovim_image_text   = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
      main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
      client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
      log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
      debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
      enable_line_number  = false,                      -- Displays the current line number instead of the current project
      blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
      buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
      file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)

      -- Rich Presence text options
      editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
      file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
      git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
      plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
      reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
      workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
      line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
    })
  end}

end)
