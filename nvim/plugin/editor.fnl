(require-macros :hibiscus.vim)
(fn set_globals []
  (g! mapleader ","))

(fn set_options []
  (local undo_dir (.. (os.getenv :HOME) :/.local./share/nvim/undo))
  (local options {:incsearch true
                  :ignorecase true
                  :encoding :UTF-8
                  :modeline true
                  :autoindent true
                  :foldmethod :expr
                  :foldexpr "nvim_treesitter#foldexpr()"
                  :tabstop 2
                  :shiftwidth 2
                  :expandtab true
                  :smarttab true
                  :laststatus 2
                  :relativenumber true
                  :vb true
                  :confirm true
                  :showmode false
                  :smartindent true
                  :wildmode "list:longest"
                  :wildignore "*.o, *.obj, *~, *vim/backups, *sass-cache, *DS_Store, vendor/rails/**, vendor/cache/**, *.gem, log/**, tmp/**, *.png, *.jpg, *.gif, *.swp, *.pyc"
                  :clipboard :unnamedplus
                  :completeopt [:menuone :noinsert :noselect :menu]
                  :signcolumn :yes
                  :wrap true
                  :linebreak true
                  :wildmenu true
                  :scrolloff 8
                  :sidescrolloff 1
                  :sidescroll 1
                  :modifiable true
                  :foldlevelstart 99
                  :exrc true
                  :number true
                  :undodir undo_dir
                  :undofile true
                  :cmdheight 2
                  :updatetime 50
                  :colorcolumn :80
                  :background :dark
                  :termguicolors true})
  (each [key val (pairs options)]
    (tset vim.opt key val)))

(fn set_mapping []
  (local opts {:noremap true})
  (local mappings [[:i :<c-j> "<cmd>lua require'luasnip'.jump(1)<CR>" opts]
                   [:s :<c-j> "<cmd>lua require'luasnip'.jump(1)<CR>" opts]
                   [:i :<c-k> "<cmd>lua require'luasnip'.jump(-1)<CR>" opts]
                   [:s :<c-k> "<cmd>lua require'luasnip'.jump(-1)<CR>" opts]
                   [:n :<F5> :<cmd>e!]
                   [:n :<leader>w "<cmd>wincmd k<CR>" opts]
                   [:n :<leader>s "<cmd>wincmd j<CR>" opts]
                   [:n :<leader>a "<cmd>wincmd h<CR>" opts]
                   [:n :<leader>d "<cmd>wincmd l<CR>" opts]
                   [:n :<leader>n :<cmd>tabnew<CR> opts]
                   [:n :<leader>z :<cmd>tabprevious<CR> opts]
                   [:n :<leader>x :<cmd>tabnew<CR> opts]
                   [:n :<leader>ev "<cmd>e ~/dotfiles/nvim/init.fnl<CR>" opts]
                   [:t :<ESC> "<c-\\><c-n>" opts]
                   [:n
                    :<leader>sv
                    "<cmd>luafile ~/dotfiles/nvim/lua/tangerine_vimrc.lua<CR>"
                    opts]
                   [:n :S :<Cmd>w<CR> opts]
                   [:n :Q :<Cmd>q<CR> opts]
                   [:v
                    :<leader>cn
                    :<Cmd>CarbonNow<CR>
                    {:noremap true :silent true}]
                   [:n :c "\"_c" opts]
                   [:x :c "\"_c" opts]
                   [:n :d "\"_d" opts]
                   [:x :p :pgvy opts]])
  (each [key val (pairs mappings)]
    (local [first second third fourth] val)
    (vim.keymap.set first second third fourth)))

(fn set_theme []
  (g! catppuccin_flavour :latte)
  (color! :catppuccin))

(set_options)
(set_globals)
(set_mapping)
(set_theme)
