" dein
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('Shougo/dein.vim')
  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
  call dein#add('cohama/lexima.vim') " 括弧やクオートを補完
  call dein#add('Shougo/denite.nvim') " ファイル開いたりバッファの切り替えするやつ
  call dein#add('Shougo/neomru.vim')
  call dein#add('tomtom/tcomment_vim') " コメントON/OFFを手軽に実行
  call dein#add('w0rp/ale') " syntaxチェッカー
  call dein#add('Vimjas/vim-python-pep8-indent') " pythonのインデントのやり方に合わせる
  call dein#add('bronson/vim-trailing-whitespace') " 行末のスペースを強調
  call dein#add('ncm2/ncm2') " 補完
  call dein#add('simeji/winresizer') " ウィンドウのリサイズ
  call dein#add('rafi/awesome-vim-colorschemes') " colorscheme
  call dein#add('airblade/vim-gitgutter') " 差分を左側に表示
  call dein#add('vim-airline/vim-airline') " powerlineとかbufferタブを表示する
  call dein#add('vim-airline/vim-airline-themes') " airlineのtheme

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" colorscheme
colorscheme pyte

" other settings
filetype on
filetype plugin on
filetype indent on
nnoremap ; :
nnoremap : ;
set fileencodings=utf-8,cp932 " 読み込み時の文字コード
set clipboard+=unnamed " クリップボードを利用
set notitle
nnoremap j gj
nnoremap k gk
nnoremap 0 g0
nnoremap $ g$
set mouse=a " マウスを利用可能にする
set showcmd " 入力中のコマンドを表示する
set smartcase " 検索で大文字と小文字の違いを無視する
set hlsearch " 検索結果をハイライトする
set expandtab " タブ入力を空白文字に置き換える
set tabstop=2 " タブ文字の表示幅
set shiftwidth=2 " 挿入するインデントの幅
set smarttab " 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
set list " 不可視文字を表示する
set number " 行番号の表示
set showmatch " 対応する括弧を強調
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set hidden " 保存されていないファイルがあるときでも別のファイルを開けるようにする
" set cursorline " カーソル行の強調
" 挿入モードでカーソル移動
:imap <c-h> <Left>
:imap <c-j> <Down>
:imap <c-k> <Up>
:imap <c-l> <Right>

" escで日本語off
if has('mac')
  set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    autocmd!
    autocmd InsertLeave * :call system(g:imeoff)
  augroup END
endif

set termguicolors
syntax on " 構文毎に文字色を変化させる

let g:python3_host_prog = expand('~/anaconda/bin/python') " denite用に最新のpythonを指定する

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

""""""""""""""""""""""""""""""
" denite.vimの設定
" unite.vimの設定
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
" バッファ一覧
noremap <C-P> :Denite buffer -mode=normal<CR>
" 今いるディレクトリ内のファイル一覧
" noremap <C-N> :Denite -buffer-name=file file -mode=normal<CR>
noremap <C-N> :Denite file_rec -mode=normal<CR>
" 最近使ったファイルの一覧
noremap <C-F> :Denite file_mru -mode=normal<CR>
" grep
noremap <C-G> :Denite grep -mode=normal<CR>
"C-J,C-Kでsplitで開く
call denite#custom#map('normal', '<C-J>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('normal', '<C-K>', '<denite:do_action:vsplit>', 'noremap')
" 新しいタブとして開く
" au FileType denite nnoremap <silent> <buffer> <expr> <C-T> denite:do_action:tabopen
call denite#custom#map('normal', '<C-T>', '<denite:do_action:tabopen>', 'noremap')
" ESCキーを2回押すと終了する
au FileType denite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType denite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" agに変更
call denite#custom#var('file_rec', 'command', ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
call denite#custom#var('grep', 'command', ['ag'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', [])
call denite#custom#var('grep', 'default_opts', ['--follow', '--no-group', '--no-color'])
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" aleの設定
" https://github.com/w0rp/ale
""""""""""""""""""""""""""""""
" エラー行に表示するマーク
let g:ale_sign_error = '⨉'
let g:ale_sign_warning = '⚠'
" エラー行にカーソルをあわせた際に表示されるメッセージフォーマット
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" エラー表示の列を常時表示
let g:ale_sign_column_always = 1

" ファイルを開いたときにlint実行
let g:ale_lint_on_enter = 1
" ファイルを保存したときにlint実行
let g:ale_lint_on_save = 1
" 編集中のlintはしない
let g:ale_lint_on_text_changed = 'never'

" 有効にするlinter
let g:ale_linters = {
\   'python': ['flake8'],
\   'R': ['lintr'],
\}

" error数とwarning数
let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '']
" Disable warnings about trailing whitespace for Python files.
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_completion_enabled = 1
""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" vim-gitgutter.vimの設定
" http://blog.remora.cx/2010/12/vim-ref-with-unite.html
""""""""""""""""""""""""""""""
set updatetime=500
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" airlineの設定
" https://github.com/vim-airline/vim-airline-themes
""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline_theme='zenburn'
""""""""""""""""""""""""""""""
