# Install dependencies

if ! command -v wezterm &> /dev/null; then
  echo "Installing wezterm..."
  curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
  echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
  sudo apt update
  sudo apt install wezterm-nightly
fi

for util in "zsh" "git" "jq" "fzf" "bat" "nvim" "zoxide"; do
 if ! command -v $util &> /dev/null; then
    echo "Missing $util, please install it."
  fi
done
