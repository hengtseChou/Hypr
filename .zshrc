#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#   _ / /\__ \ | | | | | (__
#  (_)___|___/_| |_|_|  \___|

# -----------------------------------------------------
# PATH
# -----------------------------------------------------

export PATH="/usr/lib/ccache/bin/:$PATH"
export PATH="$HOME/Scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.spicetify:$PATH"

# -----------------------------------------------------
# ZSH
# -----------------------------------------------------

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
    ohmyzsh-full-autoupdate
)
source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------
# DIRECTORIES
# -----------------------------------------------------

hypr="$HOME/Hypr"
conf="$HOME/Conf"

# -----------------------------------------------------
# GIT
# -----------------------------------------------------

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gcheck="git checkout"
alias gb="git branch"
alias gsw="git switch"
alias gd="git diff"
alias gcl="git clone"

# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

function ff() {
  if [[ $XDG_CURRENT_DESKTOP == 'Hyprland' ]]; then 
    fastfetch --config $hypr/fastfetch/config1.jsonc
  elif [[ $XDG_CURRENT_DESKTOP == 'GNOME' ]]; then 
    fastfetch --config $hypr/fastfetch/config2.jsonc 
  fi
}

alias e="exit"
alias n="nano"
alias g="gnome-text-editor"
alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first"
alias lt="eza --tree --level=1 --icons --group-directories-first"
alias na="nautilus"
alias up="paru"
alias conf="code $conf"
alias inst="paru -S"
alias hypr="code $hypr"
alias list="pacman -Qe"
alias wifi="nmtui connect"
alias clock="peaclock"
alias zshrc="nano $HOME/.zshrc"
alias search="s -p google"
alias reload="source $HOME/.zshrc"
alias uninst="paru -Rns"
alias mirrors="rate-mirrors --allow-root --protocol https arch | grep -v '^#' | sudo tee /etc/pacman.d/mirrorlist"

# -----------------------------------------------------
# PYWAL
# -----------------------------------------------------

cat $hypr/sequences

# -----------------------------------------------------
# STARSHIP
# -----------------------------------------------------

eval "$(starship init zsh)"

# -----------------------------------------------------
# ZOXIDE
# -----------------------------------------------------

eval "$(zoxide init zsh)"

# -----------------------------------------------------
# PYENV
# -----------------------------------------------------

eval "$(pyenv init -)"
export PY3_10="$HOME/.pyenv/versions/3.10.14/bin/python3.10"

# -----------------------------------------------------
# MISCS
# -----------------------------------------------------

export VISUAL=nano
setopt no_nomatch
