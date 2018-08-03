#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# ### See zprofile for other settings ###

# Alias
alias ...='cd ../..'
alias ....='cd ../../..'
alias l='ls -GFlah'
alias fc='cd "$(find . -type d | peco)"'
alias pg='cd $(ghq root)/$(ghq list | peco)'
alias pv='code $(ghq root)/$(ghq list | peco)'
alias pc='git checkout $(git branch | peco | tr -d \*)'
alias nv='nvim'

# cdr command
autoload -Uz is-at-least
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 100
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# zsh-completions
fpath=(/opt/homebrew/share/zsh-completions $fpath)

# lessに色付け
export LESSOPEN='| /opt/homebrew/Cellar/source-highlight/3.1.8_9/bin/src-hilite-lesspipe.sh %s'
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'


# Peco
# 過去のコマンドの一覧
function peco-history-selection() {
    BUFFER=$(history 1 | sort -k1,1nr | perl -ne 'BEGIN { my @lines = (); } s/^\s*\d+\*?\s*//; $in=$_; if (!(grep {$in eq $_} @lines)) { push(@lines, $in); print $in; }' | peco --query "$LBUFFER")
    CURSOR=${#BUFFER}
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# ディレクトリ移動時にlsの結果を表示する
function ls-chpwd {
  local ls_result
  ls_result=$(CLICOLOR_FORCE=1 COLUMNS=$COLUMNS ls -CGF)
  local ls_lines=$(echo "$ls_result" | wc -l | tr -d ' ')
  if [ $ls_lines -gt 10 ]; then
    echo "$ls_result" | head -n 3
    echo ' :'
    echo "$ls_result" | tail -n 3
    echo "$(ls -1 | wc -l | tr -d ' ') files exist"
  else
    echo "$ls_result"
  fi
}
add-zsh-hook chpwd ls-chpwd

# cdrのリストを表示
# ### search a destination from cdr list
function peco-get-destination-from-cdr() {
  cdr -l | \
  sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
  awk '{c=gsub("/","/"); print c,length($0),$0}' | \
  sort -n | \
  cut -d' ' -f3- | \
  peco --query "$LBUFFER"
}
### search a destination from cdr list and cd the destination
function peco-cdr() {
  local destination="$(peco-get-destination-from-cdr)"
  if [ -n "$destination" ]; then
    BUFFER="cd $destination"
    zle accept-line
  else
    zle reset-prompt
  fi
}
zle -N peco-cdr
bindkey '^x' peco-cdr

#pecoでkill
function peco-pkill() {
  for pid in `ps aux | peco | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
alias pk="peco-pkill"
