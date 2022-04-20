(require-macros :hibiscus.vim)
(require-macros :hibiscus.packer)
(local {: setup} (require :modules.functions))

(exec [[:packadd :matchit]])

(packer-setup)

(packer ; Fennel support
        (use :udayvir-singh/tangerine.nvim) (use :udayvir-singh/hibiscus.nvim)
        ; emmet
        (use :mattn/emmet-vim) ; EditorConfig
        (use :gpanders/editorconfig.nvim) ; colorscheme
        (use :shaunsingh/nord.nvim) ; Commentary
        (use! :b3nj5m1n/kommentary :config
              (fn []
                (let [kommentary_config (require :kommentary.config)]
                  (kommentary_config.use_extended_mappings))))
        ; Git interface
        (use! :TimUntersberger/neogit :requires
              [:nvim-lua/plenary.nvim :sindrets/diffview.nvim] :config
              #(require :plugins.neogit)) ; Ruby
        (use! :vinibispo/ruby.nvim :ft :ruby :requires :nvim-lua/plenary.nvim
              :config #(setup :ruby_nvim {:test_cmd :ruby :test_args {}}))
        (use! :norcalli/nvim-colorizer.lua ; Color
              :config
              (setup :colorizer
                     {1 "*" :css {:hsl_fn true} :scss {:hsl_fn true}}))
        ; Fuzzy finder
        (use! :nvim-telescope/telescope.nvim :requires
              [:nvim-lua/plenary.nvim
               :nvim-lua/popup.nvim
               :nvim-telescope/telescope-dap.nvim] :config
              #(require :plugins.telescope))
        (use! :kyazdani42/nvim-tree.lua :config #(require :plugins.nvim-tree)
              :requires :kyazdany42/nvim-web-devicons) ; Icons
        (use! :kyazdani42/nvim-web-devicons :config
              #(require :plugins.nvim-web-devicons)) ; Statusline
        (use! :nvim-lualine/lualine.nvim :requires
              {1 :kyazdani42/nvim-web-devicons :opt true} :config
              #(require :plugins.lualine)) ; Debugger
        ; (use! :mfussenegger/nvim-dap
        ; :config (#(
        ; (local dap (require :dap))
        ; (tset dap.adapters :node2 {:type :executable :command :node :args [(.. (vim.fn.stdpath :data) "/dapinstall/jsnode_dbg/" "/vscode-node-debug2/out/src/nodeDebug.js")]})
        ; (tset dap.configurations :javascript {:type :node2 :request :launch :program "${workspaceFolder}/${file}" :cwd (vim.fn.getcwd) :sourceMaps true :protocol :inspector :console :integratedTerminal})
        ; ))
        ; )
        (use :Pocco81/DAPInstall.nvim) ; Language syntax highlighting
        (use! :nvim-treesitter/nvim-treesitter :run ":TSUpdate" :config
              #(require :plugins.nvim-treesiter))
        (use! :neovim/nvim-lspconfig :config #(require :modules.lsp) :requires
              :williamboman/nvim-lsp-installer)
        (use! :hrsh7th/nvim-cmp :requires
              [:f3fora/cmp-spell
               :hrsh7th/cmp-buffer
               :hrsh7th/cmp-nvim-lsp
               :hrsh7th/cmp-nvim-lua
               :hrsh7th/cmp-path
               :saadparwaiz1/cmp_luasnip
               {1 :L3MoN4D3/LuaSnip :config #(require :plugins.luasnip)}
               :ray-x/cmp-treesitter
               :onsails/lspkind-nvim] :config
              #(require :plugins.cmp)) (use :tami5/lspsaga.nvim)
        (use! :williamboman/nvim-lsp-installer :requires :neovim/nvim-lspconfig)
        (use :rafamadriz/friendly-snippets)
        (use! :akinsho/nvim-bufferline.lua :config
              (fn []
                (vim.schedule (fn []
                                (local bufferline (require :bufferline))
                                (bufferline.setup)))))
        (use :folke/lsp-colors.nvim) ; Colors in LSP
        (use! :folke/trouble.nvim :config
              (fn []
                (local trouble (require :trouble))
                (trouble.setup))) ; Trouble
        (use :akinsho/toggleterm.nvim) (use :propet/toggle-fullscreen.nvim))
