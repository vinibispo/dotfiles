source ~/.zplug/init.zsh #init zplug
source ~/.fzf.zsh #init fzf
zplug "dracula/zsh", as:theme #set dracula as theme
zplug "zsh-users/zsh-syntax-highlighting", defer:2 #set sintax-highlighting
zplug "zsh-users/zsh-autosuggestions" #set zsh-autosuggestions
zplug "zsh-users/zsh-completions" #set zsh-completions
zplug load # load zplug
export NPM_CONFIG_PREFIX=~/.npm-global #npm-global
export PATH=$PATH:~/.npm-global/bin #npm-global
export PATH="$PATH:$HOME/.rvm/bin" #rvm
alias ls="ls --color=auto" #color to ls
export EDITOR="nvim" #set editor as nvim
eval `dircolors ~/.dir_colors` #set up dircolors
# Set up android emulator
export ANDROID_HOME=$HOME/Android/Sdk 
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
# Set up yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
