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

autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
else
	compinit -C;
fi;

export VISUAL=nano
setopt no_nomatch
setopt HIST_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS
# navigate words using Ctrl + arrow keys
# >>> CRTL + right arrow | CRTL + left arrow
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

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
# APPS
# -----------------------------------------------------

alias n="nano"
alias g="gnome-text-editor"
alias f="nautilus"
alias c="peaclock"

# -----------------------------------------------------
# SHORTCUTS
# -----------------------------------------------------

alias e="exit"
alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first"
alias lt="eza --tree --level=1 --icons --group-directories-first"
alias conf="code $conf"
alias hypr="code $hypr"
alias wifi="nmtui connect"
alias zshrc="nano $HOME/.zshrc"
alias search="s -p google"
alias reload="source $HOME/.zshrc"

function ff() {
  if [[ $XDG_CURRENT_DESKTOP == 'Hyprland' ]]; then
    fastfetch --config $hypr/fastfetch/config1.jsonc
  elif [[ $XDG_CURRENT_DESKTOP == 'GNOME' ]]; then
    fastfetch --config $hypr/fastfetch/config2.jsonc
  fi
}

# -----------------------------------------------------
# PACMAN
# -----------------------------------------------------

alias inst="paru -S"
alias uninst="paru -Rns"
alias up="paru -Syu"
alias mirrors="rate-mirrors --allow-root --protocol https arch | grep -v '^#' | sudo tee /etc/pacman.d/mirrorlist"
function pkglist() {
  local all=false
  while [[ $# -gt 0 ]]; do
    case $1 in
      -a) all=true; shift ;;
      *) return 1 ;;
    esac
  done
  if $all; then
    pacman -Qq | fzf --preview 'paru -Si {}' --layout=reverse
  else
    pacman -Qqe | fzf --preview 'paru -Si {}' --layout=reverse
  fi

}

function pkgsearch() {
  local aur=false
  while [[ $# -gt 0 ]]; do
    case $1 in
      -a) aur=true; shift ;;
      *) return 1 ;;
    esac
  done
  if $aur; then
    paru -Slqa | fzf --preview 'paru -Si {}' --layout=reverse --bind 'enter:execute(paru -S {})'
  else
    pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse --bind 'enter:execute(sudo pacman -S {})'
  fi
}

function cleanup() {
  sudo pacman -Rns $(pacman -Qtdq)
  paru -Scc
}

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

if command -v pyenv 2>&1 >/dev/null; then
	eval "$(pyenv init -)"
  export PY3_10="$HOME/.pyenv/versions/3.10.14/bin/python3.10"
fi

# -----------------------------------------------------
# FZF
# -----------------------------------------------------

FZF_ALT_C_COMMAND=""
FZF_CTRL_T_COMMAND=""
source <(fzf --zsh)
export FZF_CTRL_R_OPTS="--preview 'echo {}' --layout=reverse"
alias fzcd="fd --type directory --exclude venv --exclude virtualenv --exclude .git | fzf --preview 'tree -C {}' --layout=reverse --bind 'enter:execute(cd {})'"
alias fzfile="fd -H --type file | fzf --preview '[ -d {} ] && tree -C {} || bat --color=always --style=numbers {}' --layout=reverse --bind 'enter:execute(nano {})'"
