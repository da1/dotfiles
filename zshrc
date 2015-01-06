# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git perl cpanm)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
_Z_CMD=j
source $HOME/.zsh/z/z.sh
precmd() {
    _z --add "$(pwd -P)"
}

# fpathの追加
for cmd in git perl cpanm ; do
    fpath=($HOME/oh-my-zsh/plugins/$cmd $fpath)
done

# 補完を有効化
autoload -Uz compinit
compinit -u

alias st="git status"
alias b="git branch"
alias cm="git commit"
alias lg="git log"
alias gg="git grep"
alias gsl="git --no-pager shortlog --numbered --summary"

alias t="tmux"
alias tat="tmux a -t"
alias tls="tmux ls"
alias tn="tmux new -s"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# git checkout with peco
alias gcop='git checkout `git branch | peco | sed -e "s/\* //g" | awk "{print \$1}"`'

# http://qiita.com/ysk_1031/items/8cde9ce8b4d0870a129d
# コマンド履歴を出して検索・絞り込みするやつ
setopt hist_ignore_all_dups

function peco_select_history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
  BUFFER=$(fc -l -n 1 | eval $tac | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco_select_history
bindkey '^r' peco_select_history

# ghqでクローンしてきたレポジトリへの移動が捗るやつ
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

# 入力したコマンドがすでにコマンド履歴に含まれる場合、履歴から古いほうのコマンドを削除する
# コマンド履歴とは今まで入力したコマンドの一覧のことで、上下キーでたどれる
setopt hist_ignore_all_dups
# cd した先のディレクトリをディレクトリスタックに追加する
# ディレクトリスタックとは今までに行ったディレクトリの履歴のこと
# `cd +<Tab>` でディレクトリの履歴が表示され、そこに移動できる
setopt auto_pushd

if which rbenv >& /dev/null ; then
    eval "$(rbenv init -)"
fi
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi
if [ -d "$HOME/.plenv" ]; then
    eval "$(plenv init -)"
fi

if [ -e ~/.zsh/aws_zsh_completer.sh ]; then
    source ~/.zsh/aws_zsh_completer.sh
fi

