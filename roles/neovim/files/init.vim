autocmd BufWritePost plugins.lua source <afile> | PackerCompile

" packadd packer.nvim
lua require('plugins')

" colorscheme monokai-soda
" colorscheme monokai
" colorscheme deep-space
" set background=dark
" let g:deepspace_italics=1
" colorscheme nightfox 
let mapleader = "\<Space>"


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
set scrolloff=10 " スクロールしても上下10行は空ける
set autoread
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
set relativenumber " 相対的な行番号を表示
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
" 検索のハイライトを消す
" nnoremap <leader>n :noh<CR>
nnoremap <ESC><ESC> :nohl<CR>

" escで日本語off
if has('mac')
  set ttimeoutlen=1
  let g:imeoff = 'osascript -e "tell application \"System Events\" to key code 102"'
  augroup MyIMEGroup
    autocmd!
    autocmd InsertLeave * :call system(g:imeoff)
  augroup END
endif

" shellの設定 for coc-fzf-preview
if executable('fish')
    " use fish for embedded terminals
    set shell=fish
    " use bash for else
    let $SHELL = 'bash'
endif

set termguicolors
syntax on " 構文毎に文字色を変化させる

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
