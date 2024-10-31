ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  echo "Installing zinit..."
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

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
# zinit light laggardkernel/zsh-thefuck # [[ TOOLS ]]
zinit light jeffreytse/zsh-vi-mode # [[ TOOLS ]]
