#             _
#     _______| |__  _ __ ___
#    |_  / __| '_ \| '__/ __|
#   _ / /\__ \ | | | | | (__
#  (_)___|___/_| |_|_|  \___|

# ---------------------------------------------------------------------------- #
#                                     PATH                                     #
# ---------------------------------------------------------------------------- #

export PATH="/usr/lib/ccache/bin/:$PATH"
export PATH="$HOME/Scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.go/bin:$PATH"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/.spicetify:$PATH"

# ---------------------------------------------------------------------------- #
#                                     ZINIT                                    #
# ---------------------------------------------------------------------------- #

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zinit light starship/starship

# Add in snippets
zinit snippet OMZP::sudo

# Load completions
autoload -U compinit && compinit
zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --icons --group-directories-first $realpath'
export FZF_CTRL_R_OPTS="--layout=reverse"

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char

# ---------------------------------------------------------------------------- #
#                                  DIRECTORIES                                 #
# ---------------------------------------------------------------------------- #

hypr="$HOME/Hypr"

# ---------------------------------------------------------------------------- #
#                                      GIT                                     #
# ---------------------------------------------------------------------------- #

alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gb="git branch"
alias gsw="git switch"
alias gd="git diff"
alias gcl="git clone"

# ---------------------------------------------------------------------------- #
#                                   SHORTCUTS                                  #
# ---------------------------------------------------------------------------- #

alias e="exit"
alias g="gnome-text-editor"
alias ls="eza --icons --group-directories-first"
alias ll="eza -l --icons --group-directories-first"
alias lt="eza --tree --level=1 --icons --group-directories-first"
alias wifi="nmtui connect"
alias clock="peaclock"
alias zshrc="nano $HOME/.zshrc"
alias reload="source $HOME/.zshrc"

# ---------------------------------------------------------------------------- #
#                               UTILITY FUNCTIONS                              #
# ---------------------------------------------------------------------------- #

ff() {
  fastfetch --config $hypr/fastfetch/hyprland.jsonc
}

log-out() {
  echo "Session found: Hyprland. Logging out..."
  sleep 2
  hyprctl dispatch exit
}

change-wallpaper() {
  set -e
  # Check if no arguments are provided
  if [ $# -eq 0 ]; then
    echo "Usage: $0 <file_path>"
    exit 1
  fi

  file_path="$1"
  filename=$(basename -- "$file_path")
  extension="${filename##*.}"

  # Check if the file exists
  if [ ! -e "$file_path" ]; then
    echo "Error: file '$file_path' does not exist"
    exit 1
  fi

  # Check if the file format is supported
  supported_formats=("jpeg" "png" "gif" "pnm" "tga" "tiff" "webp" "bmp" "farbfeld" "jpg")

  if [[ ! " ${supported_formats[@]} " =~ " $extension " ]]; then
    echo "Error: file format '$extension' is not supported"
    exit 1
  fi

  hypr="$HOME/Hypr/hypr"
  wallpaper_dir="$HOME/Hypr/wallpapers"
  current_wallpaper="$wallpaper_dir/current_wallpaper.$extension"

  # remove old wallpaper
  rm "$wallpaper_dir/current_wallpaper."*
  cp -f "$file_path" "$wallpaper_dir/$filename"
  cp -f "$wallpaper_dir/$filename" "$current_wallpaper"
  echo ":: Copied $PWD/$file_path to $wallpaper_dir."
  echo ":: Creating blurred wallpaper using current wallpaper..."
  magick "$current_wallpaper" -resize 75% "$wallpaper_dir/blurred_wallpaper.png"
  magick "$current_wallpaper" -blur 50x30 "$wallpaper_dir/blurred_wallpaper.png"
  echo ":: Setting up hyprpaper config..."
  killall hyprpaper
  wal_tpl=$(cat $hypr/hyprpaper.tpl)
  output=${wal_tpl//WALLPAPER/$current_wallpaper}
  echo "$output" >$hypr/hyprpaper.conf
  hyprpaper &>/dev/null &
  disown
  echo ":: Done."
}

# ---------------------------------------------------------------------------- #
#                                    PACMAN                                    #
# ---------------------------------------------------------------------------- #

alias inst="paru -S"
alias uninst="paru -Rns"
alias up="paru -Syu"
alias mirrors="rate-mirrors --allow-root --protocol https arch | grep -v '^#' | sudo tee /etc/pacman.d/mirrorlist"
pkglist() {
  local all=false
  while [[ $# -gt 0 ]]; do
    case $1 in
    -a)
      all=true
      shift
      ;;
    *) return 1 ;;
    esac
  done
  if $all; then
    pacman -Qq | fzf --preview 'paru -Qi {}' --layout=reverse
  else
    pacman -Qqe | fzf --preview 'paru -Qi {}' --layout=reverse
  fi

}

pkgsearch() {
  local aur=false
  while [[ $# -gt 0 ]]; do
    case $1 in
    -a)
      aur=true
      shift
      ;;
    *) return 1 ;;
    esac
  done
  if $aur; then
    paru -Slqa | fzf --preview 'paru -Si {}' --layout=reverse --bind 'enter:execute(paru -S {})'
  else
    pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse --bind 'enter:execute(sudo pacman -S {})'
  fi
}

cleanup() {
  sudo pacman -Rns $(pacman -Qtdq)
  paru -Scc
}

# ---------------------------------------------------------------------------- #
#                                COLOR SEQUENCES                               #
# ---------------------------------------------------------------------------- #

cat $HOME/.config/zsh/sequences

# ---------------------------------------------------------------------------- #
#                                     PYENV                                    #
# ---------------------------------------------------------------------------- #

if command -v pyenv 2>&1 >/dev/null; then
  eval "$(pyenv init -)"
  export PY3_10="$HOME/.pyenv/versions/3.10.14/bin/python3.10"
fi

# ---------------------------------------------------------------------------- #
#                              SHELL INTEGRATIONS                              #
# ---------------------------------------------------------------------------- #

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
