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
# DOTFILES
# -----------------------------------------------------

dotfiles="$HOME/Hypr"

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

alias e="exit"
alias search="s -p google"
alias wifi="nmtui connect"
alias clock="peaclock"
alias dots="code $dotfiles"
alias ff="if [[ $XDG_CURRENT_DESKTOP == 'Hyprland' ]]; then fastfetch --config $dotfiles/fastfetch/config1.jsonc; elif [[ $XDG_CURRENT_DESKTOP == 'GNOME' ]]; then fastfetch --config $dotfiles/fastfetch/config2.jsonc; fi"
alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first"
alias lt="eza --tree --level=1 --icons --group-directories-first"
alias mirrors="rate-mirrors --allow-root --protocol https arch | grep -v '^#' | sudo tee /etc/pacman.d/mirrorlist"
alias zshrc="nano $HOME/.zshrc"
alias reload="source $HOME/.zshrc"
alias inst="paru -S"
alias uninst="paru -Rns"
alias up="paru"
alias edit="gnome-text-editor"

# -----------------------------------------------------
# PYWAL
# -----------------------------------------------------

cat $dotfiles/sequences

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
