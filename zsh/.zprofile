source ~/.zplug/init.zsh #init zplug
source ~/dotfiles/zsh/ruby.plugin.zsh
source ~/dotfiles/zsh/archlinux.plugin.zsh
source ~/dotfiles/zsh/bundle.plugin.zsh
source ~/dotfiles/zsh/git.plugin.zsh
source ~/dotfiles/zsh/asdf.plugin.zsh
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
alias rm="rm -i"
alias mux="tmuxinator"
# Set up yarn
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

