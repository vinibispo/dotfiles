source ~/.zplug/init.zsh #init zplug
source ~/dotfiles/zsh/ruby.plugin.zsh
source ~/dotfiles/zsh/archlinux.plugin.zsh

zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
#zplug "dracula/zsh", as:theme #set dracula as theme
#zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-syntax-highlighting", defer:2 #set sintax-highlighting
zplug "supercrabtree/k"
zplug "zsh-users/zsh-autosuggestions" #set zsh-autosuggestions
zplug "zsh-users/zsh-completions" #set zsh-completions
zplug "b4b4r07/emoji-cli"
zplug load # load zplug
export PATH="$PATH:$HOME/.rvm/bin" #rvm
alias ls="ls --color=auto" #color to ls
export EDITOR="nvim" #set editor as nvim
# Set up android emulator
alias mux="tmuxinator"
# Set up yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

