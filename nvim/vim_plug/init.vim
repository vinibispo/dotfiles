call plug#begin('~/.vim/plugged')
"Imported ones
Plug 'bronson/vim-trailing-whitespace'
Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'erickzanardo/vim-xclip'
Plug 'ervandew/supertab'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tmux-plugins/vim-tmux'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'brooth/far.vim'
Plug 'styled-components/vim-styled-components', { 'branch': 'main'}
Plug 'tpope/vim-unimpaired'
Plug 'wakatime/vim-wakatime'
Plug 'isRuslan/vim-es6'
Plug 'bling/vim-airline'
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'puremourning/vimspector'
Plug 'itsvinayak/image.vim'
Plug 'szw/vim-maximizer'
"Themes
Plug 'vim-airline/vim-airline-themes'
Plug 'terroo/vim-auto-markdown'
"Plug 'pangloss/vim-javascript'
Plug 'editorconfig/editorconfig-vim'
Plug 'othree/yajs.vim', {'for': 'javascript'}
Plug 'othree/es.next.syntax.vim', {'for': 'javascript'}
Plug 'pearofducks/ansible-vim'
"Plug 'HerringtonDarkholme/yats.vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'OmniSharp/omnisharp-vim'

"Syntax format for jsx
Plug 'maxmellon/vim-jsx-pretty'
"Syntax support for graphql
Plug 'jparise/vim-graphql'

Plug 'mattn/emmet-vim'
"Search
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'


"Onedark theme
Plug 'joshdick/onedark.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'sheerun/vim-polyglot'

call plug#end()
