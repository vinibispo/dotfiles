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
        (use! :numToStr/Comment.nvim :config
              (fn []
                (let [Comment (require :Comment)]
                  (Comment.setup)))) ; Git interface
        (use! :TimUntersberger/neogit :requires
              [:nvim-lua/plenary.nvim :sindrets/diffview.nvim]) ; Ruby
        (use! :vinibispo/ruby.nvim :requires :nvim-lua/plenary.nvim)
        (use! :cuducos/yaml.nvim :requires
              [:nvim-treesitter/nvim-treesitter :nvim-telescope/telescope.nvim])
        (use! :norcalli/nvim-colorizer.lua ; Color
              :config
              (setup :colorizer
                     {1 "*" :css {:hsl_fn true} :scss {:hsl_fn true}}))
        ; Fuzzy finder
        (use! :nvim-telescope/telescope.nvim :requires
              [:nvim-lua/plenary.nvim
               :nvim-lua/popup.nvim
               :nvim-telescope/telescope-dap.nvim])
        (use! :kyazdani42/nvim-tree.lua :requires :kyazdany42/nvim-web-devicons)
        ; Icons
        (use! :kyazdani42/nvim-web-devicons) ; Statusline
        (use! :nvim-lualine/lualine.nvim :requires
              {1 :kyazdani42/nvim-web-devicons :opt true}) ; Debugger
        (use :mfussenegger/nvim-dap) (use :Pocco81/dap-buddy.nvim)
        ; Language syntax highlighting
        (use! :nvim-treesitter/nvim-treesitter :run ":TSUpdate")
        (use :nvim-treesitter/playground)
        (use! :neovim/nvim-lspconfig :requires :williamboman/nvim-lsp-installer)
        (use! :hrsh7th/nvim-cmp :requires
              [:f3fora/cmp-spell
               :hrsh7th/cmp-buffer
               :hrsh7th/cmp-nvim-lsp
               :hrsh7th/cmp-nvim-lua
               :hrsh7th/cmp-path
               :saadparwaiz1/cmp_luasnip
               [:L3MoN4D3/LuaSnip]
               :ray-x/cmp-treesitter
               :onsails/lspkind-nvim]) (use :tami5/lspsaga.nvim)
        (use! :williamboman/nvim-lsp-installer :requires :neovim/nvim-lspconfig)
        (use :rafamadriz/friendly-snippets)
        (use! :akinsho/bufferline.nvim :config
              (fn []
                (vim.schedule (fn []
                                (local bufferline (require :bufferline))
                                (bufferline.setup {})))))
        (use :ellisonleao/carbon-now.nvim) (use :folke/lsp-colors.nvim)
        ; Colors in LSP
        (use! :folke/trouble.nvim :config
              (fn []
                (local trouble (require :trouble))
                (trouble.setup))) ; Trouble
        (use! :jose-elias-alvarez/null-ls.nvim :requires :nvim-lua/plenary.nvim)
        (use! :j-hui/fidget.nvim :config
              (fn []
                (local fidget (require :fidget))
                (fidget.setup {}))) (use :akinsho/toggleterm.nvim)
        (use :propet/toggle-fullscreen.nvim)
        (use! :folke/todo-comments.nvim :config
              (fn []
                (local todo-comments (require :todo-comments))
                (todo-comments.setup))) (use :andweeb/presence.nvim)
        (use :glepnir/dashboard-nvim) (use :rcarriga/nvim-notify))
