let mapleader=","
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
      split term://bash
      resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>
map ; :Files<CR>
map <C-]> :NERDTreeToggle<CR>
map <C-F> :Ag<CR>
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>gc :GBranches
map <F5> :e!<CR>                    " force reload current file
map <F6> :CtrlPClearAllCaches<CR>   " clear all CtrlP cache
map <leader>W :w<CR>
map <leader>w :wincmd k<CR>        " go window up
map <leader>s :wincmd j<CR>        " go window down
map <leader>a :wincmd h<CR>        " go window left
map <leader>d :wincmd l<CR>        " go window right
map <leader>v :vertical :new<CR>   " open new vertical window
map <leader>h :new<CR>             " open a new horizontal window
map <leader>q :q<CR>               " it quit current vim buffer
map <leader>Q :q!<CR>              " it force quit current vim buffer
map <leader>n :tabnew<CR>          " create a new tab
map <leader>z :tabprevious<CR>     " move to previous tab
map <leader>x :tabnext<CR>         " move to next tab
map <leader>y :call system('xclip -selection clipboard', @0)<CR>  " move last yank selection to xclip
map <leader>b :CtrlPBuffer<cr>
map <leader>t :CtrlPTag<cr>
map <leader>ev :e ~/dotfiles/nvim/init.vim <CR>
map <leader>sv :source ~/.config/nvim/init.vim <CR>
"nmap <ESC> :call coc#util#float_hide() <CR>
"autocmd CursorHold * silent call CocActionAsync('doHover')
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> S :w<CR>
nmap <silent> Q :q<CR>
nmap Z :call CocAction('doHover')<CR>
" Auto indent pasted text
nnoremap p p=`]<C-o>
nnoremap P P=`]<C-o>
