filetype on
" according to file type load different plug-in
filetype plugin on
filetype indent on
" ノーマルモード時だけ ; と : を入れ替える
nnoremap ; :
nnoremap : ;"
"読み込み時の文字コード"
set fileencodings=utf-8,cp932
set clipboard+=unnamed

" Thanks for flying Vimを消す
set notitle
" タイトルを書き換える
let &titleold=getcwd()
" gj,gk,g0,g$のリマップ
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$

" マウスを利用可能にする
if !has('nvim')
  set mouse=a
  set ttymouse=xterm2
endif
if has('nvim')
  set mouse=a
endif

""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" 各種オプションの設定
""""""""""""""""""""""""""""""
" スワップファイルは使わない(ときどき面倒な警告が出るだけで役に立ったことがない)
set noswapfile
" カーソルが何行目の何列目に置かれているかを表示する
" set ruler
" ウインドウのタイトルバーにファイルのパス情報等を表示する
set title
" コマンドラインモードで<Tab>キーによるファイル名補完を有効にする
set wildmenu
" 入力中のコマンドを表示する
set showcmd
" 小文字のみで検索したときに大文字小文字を無視する
set smartcase
" 検索結果をハイライト表示する
set hlsearch
" タブ入力を複数の空白入力に置き換える
set expandtab
" 検索ワードの最初の文字を入力した時点で検索を開始する
set incsearch
" 保存されていないファイルがあるときでも別のファイルを開けるようにする
set hidden
" 不可視文字を表示する
set list
" タブと行の続きを可視化する
set listchars=tab:>\ ,extends:<
" 行番号を表示する
set number
" 対応する括弧やブレースを表示する
set showmatch
" 改行時に前の行のインデントを継続する
set autoindent
" 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smartindent
" タブ文字の表示幅
set tabstop=2
" Vimが挿入するインデントの幅
set shiftwidth=2
" 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set smarttab
" カーソル行の強調
" set cursorline
" カーソル列の強調
" set cursorcolumn
tnoremap <silent> <ESC> <C-\><C-n>
" Rでアンダーバーを入れたときに<-と表示されないようにする
""""""""""""""""""""""""""""""



""""""""""""""""""""""""""""""
" 全角スペースの表示
" http://inari.hatenablog.com/entry/2014/05/05/231307
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
endif
""""""""""""""""""""""""""""""


" """"""""""""""""""""""""""""""
" " Dein 始まり
" """"""""""""""""""""""""""""""
" if &compatible
"   set nocompatible
" endif
" set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
"
" call dein#begin(expand('~/.vim/dein'))
"
" call dein#add('Shougo/dein.vim')
" call dein#add('cohama/lexima.vim')
" " ファイルオープンを便利に
" call dein#add('Shougo/denite.nvim')
" " Unite.vimで最近使ったファイルを表示できるようにする．nerdtreeと同等
" call dein#add('Shougo/neomru.vim')
" " コメントON/OFFを手軽に実行
" call dein#add('tomtom/tcomment_vim')
" " ログファイルを色づけしてくれる
" call dein#add('vim-scripts/AnsiEsc.vim')
" " 各言語に対するシンタックスを定義
" call dein#add('w0rp/ale')
" " pythonのインデントのやり方に従わせる
" call dein#add('Vimjas/vim-python-pep8-indent')
" " ctag,gtagの自動生成
" call dein#add('jsfaint/gen_tags.vim')
" " 主にpythonの関数の宣言元をたどるのに使用
" call dein#add('davidhalter/jedi-vim')
" " call dein#add('davidhalter/jedi')
" " Rの補完
" " call dein#add('jalvesaq/Nvim-R')
" " call dein#add('gaalcaras/ncm-R')
" " Ruby向けにendを自動挿入してくれる
" call dein#add('tpope/vim-endwise')
" " Gitで差分を左端に表示するやつ
" call dein#add('airblade/vim-gitgutter')
" " ステータスラインに色付け
" call dein#add('vim-airline/vim-airline')
" call dein#add('vim-airline/vim-airline-themes')
" " 行末のスペースに色付け
" call dein#add('bronson/vim-trailing-whitespace')
" " 補完
" " call dein#add('Shougo/deoplete.nvim')
" " let g:deoplete#enable_at_startup = 1
" " 補完
" call dein#add('roxma/nvim-completion-manager')
" " vimproc
" call dein#add('Shougo/vimproc.vim', {
" \ 'build' : {
" \     'windows' : 'tools\\update-dll-mingw',
" \     'cygwin' : 'make -f make_cygwin.mak',
" \     'mac' : 'make',
" \     'linux' : 'make',
" \     'unix' : 'gmake',
" \    },
" \ })
" " ウィンドウのリサイズ
" " CTRL-Eの後にhjklで調整する
" call dein#add('simeji/winresizer')
" " Terminal
" call dein#add('mklabs/split-term.vim')
" " colorscheme
" if !has('nvim')
"   " Neocomplete
"   call dein#add('Shougo/neocomplete.vim')
"   let g:neocomplete#enable_at_startup = 1
"   call dein#add('lifepillar/vim-solarized8')
"   let g:solarized_use16 = 1
"   set background=light
"   colorscheme solarized8_high
" endif
" if has('nvim')
"   " call dein#add('frankier/neovim-colors-solarized-truecolor-only')
"   " set background=dark
"   " colorscheme solarized
"   call dein#add('rafi/awesome-vim-colorschemes')
"   " set background=dark
"   colorscheme pyte
"   " colorscheme deep-space
"   " colorscheme iceberg
"   " colorscheme papercolor
"   " colorscheme nord
"   " colorscheme molokai
"   " let g:nord_italic_comments = 1
"   " let g:nord_uniform_status_lines = 1
"   " let g:nord_comment_brightness = 12
"   " let g:nord_uniform_diff_background = 1
" endif
"
" " (中略)
"
" call dein#end()
"
" if dein#check_install()
"   call dein#install()
" endif
"
" """"""""""""""""""""""""""""""
" " Dein 終わり
" """"""""""""""""""""""""""""""


" """"""""""""""""""""""""""""""
" """"""""""""""""""""""""""""""
" """ 以下プラグインの細かい設定
" """ 削除するときは，以下の設定も消すこと
" """"""""""""""""""""""""""""""
" """"""""""""""""""""""""""""""
"
"
" """"""""""""""""""""""""""""""
" " denite.vimの設定
" " unite.vimの設定
" " http://blog.remora.cx/2010/12/vim-ref-with-unite.html
" """"""""""""""""""""""""""""""
" " バッファ一覧
" noremap <C-P> :Denite buffer -mode=normal<CR>
" " 今いるディレクトリ内のファイル一覧
" " noremap <C-N> :Denite -buffer-name=file file -mode=normal<CR>
" noremap <C-N> :Denite file_rec -mode=normal<CR>
" " 最近使ったファイルの一覧
" noremap <C-F> :Denite file_mru -mode=normal<CR>
" " grep
" noremap <C-G> :Denite grep -mode=normal<CR>
" "C-J,C-Kでsplitで開く
" call denite#custom#map('normal', '<C-J>', '<denite:do_action:split>', 'noremap')
" call denite#custom#map('normal', '<C-K>', '<denite:do_action:vsplit>', 'noremap')
" " 新しいタブとして開く
" " au FileType denite nnoremap <silent> <buffer> <expr> <C-T> denite:do_action:tabopen
" call denite#custom#map('normal', '<C-T>', '<denite:do_action:tabopen>', 'noremap')
" " ESCキーを2回押すと終了する
" au FileType denite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
" au FileType denite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" " agに変更
" call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
" call denite#custom#var('grep', 'command', ['ag'])
" call denite#custom#var('grep', 'recursive_opts', [])
" call denite#custom#var('grep', 'pattern_opt', [])
" call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])
" """"""""""""""""""""""""""""""
"
"
" """"""""""""""""""""""""""""""
" " vim-gitgutter.vimの設定
" " http://blog.remora.cx/2010/12/vim-ref-with-unite.html
" """"""""""""""""""""""""""""""
" set updatetime=500
" if exists('&signcolumn')  " Vim 7.4.2201
"   set signcolumn=yes
" else
"   let g:gitgutter_sign_column_always = 1
" endif
" """"""""""""""""""""""""""""""
"
"
" """"""""""""""""""""""""""""""
" " airlineの設定
" " https://github.com/vim-airline/vim-airline-themes
" """"""""""""""""""""""""""""""
" let g:airline_powerline_fonts = 1
" set laststatus=2
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline_theme='base16_ocean'
" " let g:airline_theme='iceberg'
" """"""""""""""""""""""""""""""
"
" """"""""""""""""""""""""""""""
" " aleの設定
" " https://github.com/w0rp/ale
" """"""""""""""""""""""""""""""
" " エラー行に表示するマーク
" let g:ale_sign_error = '⨉'
" let g:ale_sign_warning = '⚠'
" " エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" " エラー表示の列を常時表示
" let g:ale_sign_column_always = 1
"
" " ファイルを開いたときにlint実行
" let g:ale_lint_on_enter = 1
" " ファイルを保存したときにlint実行
" let g:ale_lint_on_save = 1
" " 編集中のlintはしない
" let g:ale_lint_on_text_changed = 'never'
"
" " 有効にするlinter
" let g:ale_linters = {
" \   'python': ['flake8'],
" \   'R': ['lintr'],
" \}
"
" " error数とwarning数
" let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '']
" " Disable warnings about trailing whitespace for Python files.
" let g:ale_warn_about_trailing_whitespace = 0
" let g:ale_completion_enabled = 1
" """"""""""""""""""""""""""""""
"
" """"""""""""""""""""""""""""""
" " gen_tags.vimの設定
" " https://github.com/jsfaint/gen_tags.vim
" """"""""""""""""""""""""""""""
" let g:gen_tags#ctags_auto_gen = 1
" let g:gen_tags#gtags_auto_gen = 1
" """"""""""""""""""""""""""""""
"
" """"""""""""""""""""""""""""""
" " jedi-vimの設定
" " https://github.com/jsfaint/gen_tags.vim
" """"""""""""""""""""""""""""""
" " 勝手にキーバインド設定やら自動補完などをやるので潰しておく
" " let g:jedi#auto_initialization = 1
" " let g:jedi#auto_vim_configuration = 0
" " let g:jedi#smart_auto_mappings = 0
" " let g:jedi#completions_enabled = 0
" " コード参照のキーバインドを登録
" " CTRL-Oで戻る
" " RubyだとCTRL-]でコード参照ができる
" """ let g:jedi#goto_command = "<Leader>d"
" """ Show Documentation/Pydoc K
" """ Renaming <leader>r
" """ Goto assignments <leader>g
" """"""""""""""""""""""""""""""
"
" """"""""""""""""""""""""""""""

" escで日本語off
if has('mac')
  set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    autocmd!
    autocmd InsertLeave * :call system(g:imeoff)
  augroup END
  "noremap <silent> <ESC> <ESC>:call system(g:imeoff)<CR>
endif

" set termguicolors

" 構文毎に文字色を変化させる
syntax on
