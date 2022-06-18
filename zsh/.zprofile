# if ZSH_DOTFILES is not defined, use the current script's directory
[[ -z "$ZSH_DOTFILES" ]] && export ZSH_DOTFILES="${${(%):-%x}:a:h}"
source ~/.zplug/init.zsh #init zplug
source "$ZSH_DOTFILES/zsh_plugins/ruby.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/archlinux.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/bundle.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/git.plugin.zsh"
#source "$ZSH_DOTFILES/zsh_plugins/asdf.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/ranger_cd.zsh"
source "$ZSH_DOTFILES/zsh_plugins/common_aliases.zsh"
source "$ZSH_DOTFILES/zsh_plugins/clipboard.zsh"
source "$ZSH_DOTFILES/zsh_plugins/docker-compose.plugin.zsh"
#zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "kiurchv/asdf.plugin.zsh", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2 #set sintax-highlighting
zplug "supercrabtree/k"
zplug "zsh-users/zsh-autosuggestions" #set zsh-autosuggestions
zplug "zsh-users/zsh-completions" #set zsh-completions
zplug "b4b4r07/emoji-cli"
zplug load # load zplug

export ANDROID_SDK_ROOT=$HOME/Android/Sdk

# Ubuntu make installation of Ubuntu Make binary symlink
PATH=/home/vinibispodev/.local/share/umake/bin:$PATH

