let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let ignored_files = '--glob "!.git/*" --glob "!node_modules/*" --glob "!app/cache/*" --glob "!app/logs/*" --glob "!web/uploads/*" --glob "!web/bundles/*" --glob "!tags" --glob "!web/css/*" --glob "!web/js/*" --glob "!var/logs/*" --glob "!var/cache/*" --glob "!elm-stuff/*"'
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --no-ignore --follow '.ignored_files.' --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --no-ignore --follow '.ignored_files
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_branch_actions = {
                  \ 'rebase': {
                  \   'prompt': 'Rebase> ',
                  \   'execute': 'echo system("{git} rebase {branch}")',
                  \   'multiple': v:false,
                  \   'keymap': 'ctrl-r',
                  \   'required': ['branch'],
                  \   'confirm': v:false,
                  \ },
                  \ 'track': {
                  \   'prompt': 'Track> ',
                  \   'execute': 'echo system("{git} checkout --track {branch}")',
                  \   'multiple': v:false,
                  \   'keymap': 'ctrl-t',
                  \   'required': ['branch'],
                  \   'confirm': v:false,
                  \ },
                  \}
