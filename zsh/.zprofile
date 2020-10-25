source ~/.zplug/init.zsh #init zplug
source ~/ruby.plugin.zsh
source ~/archlinux.plugin.zsh

#zplug "dracula/zsh", as:theme #set dracula as theme
zplug romkatv/powerlevel10k, as:theme, depth:1
zplug "zsh-users/zsh-syntax-highlighting", defer:2 #set sintax-highlighting
zplug "supercrabtree/k"
zplug "zsh-users/zsh-autosuggestions" #set zsh-autosuggestions
zplug "zsh-users/zsh-completions" #set zsh-completions
zplug "b4b4r07/emoji-cli"
zplug load # load zplug
export NPM_CONFIG_PREFIX=~/.npm-global #npm-global
export PATH=$PATH:~/.npm-global/bin #npm-global
export PATH="$PATH:$HOME/.rvm/bin" #rvm
alias ls="ls --color=auto" #color to ls
export EDITOR="nvim" #set editor as nvim
# Set up android emulator
export ANDROID_HOME=$HOME/Android/Sdk 
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias mux="tmuxinator"
# Set up yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
