# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="edvardm" # random

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  yarn
  tmux
  fzf
  ag
  themes
  web-search
  copyfile
)

source $ZSH/oh-my-zsh.sh

# NVM configuration
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -f ~/.myenvs ]; then
    source ~/.myenvs
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function openCode {
  if [ $# -eq 0 ]; then
    code ./
  else
    code $1
  fi
}

function openNvim {
  if [ $# -eq 0 ]; then
    nvim ./
  else
    nvim $1
  fi
}

# Check for tmux session and attach if exists
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux -l new -t wez
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export GIT_EDITOR=nvim
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# bun completions
[ -s "/home/carlos/.bun/_bun" ] && source "/home/carlos/.bun/_bun"

# Completition styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-tab fzf --preview 'tree -C {} | head -200'

# export FZF_DEFAULT_COMMAND='ag -g ""'
source <(fzf --zsh)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval $(thefuck --alias)

source <(kubectl completion zsh)
eval "$(zoxide init zsh)"

# [[ ALIASES ]]
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias zshconfig="v ~/.zshrc"
alias v=openNvim
alias cd="z"
# tmux 
alias tmux-save="~/configs/terminal/scripts/tmux-session.sh save"
alias tmux-restore="~/configs/terminal/scripts/tmux-session.sh restore"
