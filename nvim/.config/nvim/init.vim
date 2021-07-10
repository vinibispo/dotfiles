syntax on
filetype off
set confirm
source ./vim_plug/init.vim
let g:ruby_host_prog='~/.asdf/shims/neovim-ruby-host'
let g:coc_node_path='~/.asdf/installs/nodejs/12.15.0/bin/node'
" vim javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1


source ./basic-config.vim
source ./fzf.vim

filetype plugin indent on    " required
source ./coc-config/init.vim


source ./ctrlp.vim



set t_Co=256


set background=dark
source ./theme/onedark.vim
source ./theme/airline.vim


source ./coc-config/mapping.vim
if (has("termguicolors"))
 set termguicolors
endif

source ./neovim-tmux.vim
source ./telescope.vim
source ./shortcuts.vim
source ./far.vim
colorscheme gruvbox
