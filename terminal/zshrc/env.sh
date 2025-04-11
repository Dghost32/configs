[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# [ -f ~/.myenvs ] && source ~/.myenvs

# eval "$(thefuck --alias)"
eval "$(fzf --zsh)"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"

# [[ ENVARS ]]
# ANDROID
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

#MAVEN
M2_HOME='/opt/apache-maven-3.9.9'
PATH="$M2_HOME/bin:$PATH"
export PATH

export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$HOME/.rvm/bin"
export GIT_EDITOR=nvim
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export FZF_BASE='/home/linuxbrew/.linuxbrew/bin/fzf' # FZF base path
export PATH=$PATH:$HOME/.local/bin

[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
# [ -s "/home/carlos/.bun/_bun" ] && source "/home/carlos/.bun/_bun" # Load bun
