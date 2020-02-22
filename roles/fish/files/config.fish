# 日本語
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8

# openコマンド
alias o=open

# ディレクトリ移動用
function peco_recentd
  z -l | peco | awk '{ print $2 }' | read recentd
  cd $recentd
end

#fisherパッケージoh-my-fish/plugin-pecoの設定
function fish_user_key_bindings
  bind \cr peco_select_history # Bind for prco history to Ctrl+r
  bind \cx peco_recentd
end
