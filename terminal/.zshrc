if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Check if zinit is installed
if [ ! -d "$ZINIT_HOME" ]; then
  echo "Installing zinit..."
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "$ZINIT_HOME/zinit.zsh"

# Load plugins
zinit light zsh-users/zsh-syntax-highlighting # [[ CORE ]]
zinit light zsh-users/zsh-completions # [[ CORE ]]
zinit light zsh-users/zsh-autosuggestions # [[ CORE ]] 
zinit light Aloxaf/fzf-tab # [[ UI ]]
zinit light chrissicool/zsh-256color # [[ UI ]]
zinit ice depth=1; zinit light romkatv/powerlevel10k # [[ UI ]]
zinit light GeoLMg/apt-zsh-plugin # [[ ALIASES ]]
zinit light unixorn/fzf-zsh-plugin # [[ ALIASES ]]
zinit light mdumitru/git-aliases # [[ ALIASES ]]
zinit light laggardkernel/zsh-thefuck # [[ TOOLS ]]
zinit light jeffreytse/zsh-vi-mode # [[ TOOLS ]]

autoload -U compinit && compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# [[ ALIASES ]]
alias zshconfig="v ~/.zshrc"
alias v="nvim"
alias cd="z"
alias ls='ls --color'
alias la='ls -la'
alias tmux-save="~/configs/terminal/scripts/tmux-session.sh save"
alias tmux-restore="~/configs/terminal/scripts/tmux-session.sh restore"

# [[ History vars ]]
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
# [[ OPTS ]]
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt autocd

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval $(thefuck --alias)
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Check for tmux session and attach if exists
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  exec tmux -l new -t wez
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
if [ -f ~/.myenvs ]; then
  source ~/.myenvs
fi

# [[ ENVARS ]]
export NVM_DIR="$HOME/.nvm"
export PATH="$PATH:$HOME/.rvm/bin"
export GIT_EDITOR=nvim
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
export FZF_BASE='/home/linuxbrew/.linuxbrew/bin/fzf' # FZF base path
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "/home/carlos/.bun/_bun" ] && source "/home/carlos/.bun/_bun" # Load bun
