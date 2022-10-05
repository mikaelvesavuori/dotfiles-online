export USERNAME=

source ~/.dotfiles/.functions
source ~/.dotfiles/.alias
source ~/.dotfiles/.env

# enable the default zsh completions!
autoload -Uz compinit && compinit

# Path to your oh-my-zsh installation.
export ZSH="/Users/$USERNAME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(git)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

source $ZSH/oh-my-zsh.sh
