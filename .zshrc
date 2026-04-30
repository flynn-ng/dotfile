ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"


zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# zinit ice as"command" from"gh-r" \
#           atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#           atpull"%atclone" src"init.zsh"
# zinit light starship/starship

autoload -U compinit && compinit

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

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
setopt incappendhistory

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup
zstyle ':fzf-tab:*' popup-min-size 80 12


# ngrok completion
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias v='nvim'
alias vim='nvim'
alias vi='nvim'


fpath+=${ZDOTDIR:-~}/.zsh_functions

# zsh
eval "$(fzf --zsh)"


export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tre --color=always {} | head -200'"

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    export|unset) fzf --preview "eval 'echo \$' {}" "$@" ;;
    ssh)          fzf --preview 'dig {}' "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

export BAT_THEME=DarkNeon

alias ls="eza --color=always --git --icons=always -1"


eval "$(zoxide init --cmd cd zsh)"

if command -v docker &> /dev/null; then
  source <(docker completion zsh)
fi

if command -v kubectl &> /dev/null; then
  source <(kubectl completion zsh)
fi

if command -v minikube &> /dev/null; then 
  source <(minikube completion zsh)
fi

if command -v nats &> /dev/null; then
  source <(nats --completion-script-zsh)
fi

# SECRET KEY
[[ -f ~/.secrets.sh ]] && source ~/.secrets.sh


# export CLAUDE_CODE_USE_VERTEX=1
# export CLOUD_ML_REGION=global
# export ANTHROPIC_VERTEX_PROJECT_ID="prj-vnm-prod-be-sg-1"
#
# export ANTHROPIC_DEFAULT_OPUS_MODEL='claude-opus-4-7'
# export ANTHROPIC_DEFAULT_SONNET_MODEL='claude-sonnet-4-6'
# export ANTHROPIC_DEFAULT_HAIKU_MODEL='claude-haiku-4-5@20251001'

export CLAUDE_CODE_NO_FLICKER=1

if command -v gcloud &> /dev/null; then
  LAST_RUN_FILE="$HOME/.gcloud_adc_last_login"
  if [[ ! -f "$LAST_RUN_FILE" || "$(date +%F)" != "$(cat $LAST_RUN_FILE)" ]]; then
    gcloud auth application-default login
    date +%F > "$LAST_RUN_FILE"
  fi
fi

if command -v direnv &> /dev/null; then
    eval "$(direnv hook zsh)"
fi

