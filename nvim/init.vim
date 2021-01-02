syntax on
filetype off
set confirm
source ~/dotfiles/nvim/vim_plug/init.vim
let g:ruby_host_prog='~/.rvm/gems/ruby-2.7.2/bin/neovim-ruby-host'
" vim javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1


source ~/dotfiles/nvim/fzf.vim

filetype plugin indent on    " required

source ~/dotfiles/nvim/coc-config/init.vim

source ~/dotfiles/nvim/basic-config.vim

source ~/dotfiles/nvim/ctrlp.vim



set t_Co=256


set background=dark
source ~/dotfiles/nvim/theme/onedark.vim
source ~/dotfiles/nvim/theme/airline.vim


source ~/dotfiles/nvim/coc-config/mapping.vim
if (has("termguicolors"))
 set termguicolors
endif

source ~/dotfiles/nvim/neovim-tmux.vim
source ~/dotfiles/nvim/shortcuts.vim
source ~/dotfiles/nvim/far.vim
source ~/dotfiles/nvim/vimspector.vim
