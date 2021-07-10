syntax on
filetype off
set confirm
runtime vim_plug/init.vim
let g:ruby_host_prog='~/.asdf/shims/neovim-ruby-host'
let g:coc_node_path='~/.asdf/installs/nodejs/12.15.0/bin/node'
" vim javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1


runtime basic-config.vim
runtime fzf.vim

filetype plugin indent on    " required
runtime coc-config/init.vim


runtime ctrlp.vim



set t_Co=256


set background=dark
runtime theme/onedark.vim
runtime theme/airline.vim


runtime coc-config/mapping.vim
if (has("termguicolors"))
 set termguicolors
endif

runtime neovim-tmux.vim
runtime telescope.vim
runtime shortcuts.vim
runtime far.vim
colorscheme gruvbox
