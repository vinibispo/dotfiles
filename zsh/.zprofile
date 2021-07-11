# if ZSH_DOTFILES is not defined, use the current script's directory
[[ -z "$ZSH_DOTFILES" ]] && export ZSH_DOTFILES="${${(%):-%x}:a:h}"
source ~/.zplug/init.zsh #init zplug
source "$ZSH_DOTFILES/zsh_plugins/ruby.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/archlinux.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/bundle.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/git.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/asdf.plugin.zsh"
source "$ZSH_DOTFILES/zsh_plugins/ranger_cd.zsh"
source "$ZSH_DOTFILES/zsh_plugins/common_aliases.zsh"
source "$ZSH_DOTFILES/zsh_plugins/clipboard.zsh"
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  #kubecontext   # Kubectl context section
  terraform     # Terraform workspace section
  time
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status

  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_USER_COLOR="yellow"
SPACESHIP_USER_SHOW=always
SPACESHIP_TIME_SHOW=true
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
SPACESHIP_CONDA_SYMBOL=" \U0001F40D "
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
#zplug "dracula/zsh", as:theme #set dracula as theme
#zplug "romkatv/powerlevel10k", as:theme, depth:1
#
zplug "kiurchv/asdf.plugin.zsh", defer:2
zplug "zsh-users/zsh-syntax-highlighting", defer:2 #set sintax-highlighting
zplug "supercrabtree/k"
zplug "zsh-users/zsh-autosuggestions" #set zsh-autosuggestions
zplug "zsh-users/zsh-completions" #set zsh-completions
zplug "b4b4r07/emoji-cli"
zplug load # load zplug

export ANDROID_SDK_ROOT=$HOME/Android/Sdk

