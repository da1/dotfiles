if filereadable("/etc/vimrc")
    source /etc/vimrc
elseif filereadable("/etc/vim/vimrc")
    source /etc/vim/vimrc
endif

"==================== NeoBundle ====================
set nocompatible               " Be iMproved
filetype off                   " Required!

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
call neobundle#end()

NeoBundle 'git://github.com/Shougo/neobundle.vim.git'
NeoBundle 'git://github.com/Shougo/unite.vim.git'
NeoBundle 'git://github.com/Shougo/neocomplcache.git'
NeoBundle 'git://github.com/Shougo/vimshell.git'
NeoBundle 'git://github.com/Shougo/vimfiler.git'
NeoBundle 'git://github.com/Shougo/vimproc.git', { 'build' : {
    \       'unix' : 'make -f make_unix.mak',
    \       'mac' : 'make -f make_mac.mak',
    \       },
    \   }

NeoBundle 'git://github.com/Shougo/echodoc.git'
NeoBundle 'git://github.com/vim-scripts/Align.git'
NeoBundle 'git://github.com/vim-jp/vimdoc-ja.git'
NeoBundle 'git://github.com/tpope/vim-surround.git'
NeoBundle 'git://github.com/tpope/vim-pathogen.git'
"NeoBundle 'git://github.com/scrooloose/syntastic.git'
NeoBundle 'git://github.com/thinca/vim-ref.git'
NeoBundle 'git://github.com/kana/vim-operator-user.git'
NeoBundle 'git://github.com/kana/vim-operator-replace.git'
NeoBundle 'git://github.com/vim-scripts/YankRing.vim.git'
NeoBundle 'git://github.com/thinca/vim-visualstar.git'
NeoBundle 'git://github.com/nathanaelkane/vim-indent-guides.git'
NeoBundle 'git://github.com/ynkdir/vim-funlib.git'
NeoBundle 'git://github.com/da1/vim-toggle.git'
NeoBundle 'git://github.com/rking/ag.vim.git'
NeoBundle 'git://github.com/sakuraiyuta/commentout.vim.git'
NeoBundle 'git://github.com/ujihisa/unite-colorscheme.git'
NeoBundle 'git://github.com/Lokaltog/vim-easymotion.git'
NeoBundle 'git://github.com/mattn/webapi-vim.git'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle 'kien/ctrlp.vim'
"NeoBundle 'ujihisa/camelcasemotion'
NeoBundle 'osyo-manga/vim-over'
NeoBundle 'itchyny/calendar.vim'
NeoBundle 'Shougo/neomru.vim'

"TextObj
NeoBundle 'git://github.com/h1mesuke/textobj-wiw.git'
NeoBundle 'git://github.com/kana/vim-textobj-user.git'

"snippet
NeoBundle 'Shougo/neosnippet'
NeoBundle 'honza/vim-snippets'
NeoBundle 'Shougo/neosnippet-snippets'

"HTML
NeoBundle 'git://github.com/mattn/emmet-vim.git'

" gosh
NeoBundle 'git://github.com/aharisu/vim_goshrepl.git'

"Perl
NeoBundle 'git://github.com/nakatakeshi/jump2pm.vim.git'

"haskell
NeoBundle 'git://github.com/eagletmt/ghcmod-vim.git'
NeoBundle 'git://github.com/ujihisa/neco-ghc.git'

"coffee
NeoBundle 'git://github.com/kchmck/vim-coffee-script.git'

"git
NeoBundle 'git://github.com/Shougo/vim-vcs.git'
NeoBundle 'git://github.com/tpope/vim-fugitive.git'
NeoBundle 'git://github.com/gregsexton/gitv.git'
NeoBundle 'git://github.com/vim-scripts/extradite.vim.git'

"binary
"http://d.hatena.ne.jp/alwei/20120220/1329756198
NeoBundle 'git://github.com/Shougo/vinarise.git'

"neta
NeoBundle 'thinca/vim-scouter'

filetype plugin indent on     " Required!
"
" Brief help
" :NeoBundleList          - list configured bundles
" :NeoBundleInstall(!)    - install(update) bundles
" :NeoBundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" Installation check.
if neobundle#exists_not_installed_bundles()
  echomsg 'Not installed bundles : ' .
        \ string(neobundle#get_not_installed_bundle_names())
  echomsg 'Please execute ":NeoBundleInstall" command.'
  "finish
endif

"============================================================

if filereadable(expand('$HOME/.vimrc.local'))
    source $HOME/.vimrc.local
endif

"vi互換off
set nocompatible
set number
set tabstop=4
set shiftwidth=4
set expandtab
"スペルチェッカ
"http://d.hatena.ne.jp/h1mesuke/20100803/p1
"set spell
"ベル
set noerrorbells
syntax on

"不可視文字の表示
set list listchars=tab:^_,trail:_
"全角スペースをハイライト
scriptencoding utf-8
augroup highlightIdegraphicSpace
    autocmd!
    autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
    autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END

"色設定
function! DefaultStyle ()
    colorscheme peachpuff
endfunction
:command! DefaultStyle :call DefaultStyle()

function! DemoStyle ()
    colorscheme zellner
endfunction
:command! DemoStyle :call DemoStyle()

call DefaultStyle()

"対応するカッコを表示
set showmatch
"カーソルは対応するカッコに飛ばない
set matchtime=0
set autoindent

"コメント行で改行するとコメントを自動挿入する機能をOFF
autocmd FileType * setlocal formatoptions=cq
"編集中のファイルのステータスを常時表示
set laststatus=2

"文字コード自動識別
set encoding=utf-8
set fileencodings=utf-8,euc_jp,iso-2022-jp

".viminfo
set viminfo='1000,<500

"ファイルタイプによるシンタックス割り当て
autocmd BufNewFile,BufRead *.t,*.psgi,cpanfile set filetype=perl
autocmd BufNewFile,BufRead *.scala set filetype=scala
autocmd BufNewFile,BufRead *.coffee set filetype=coffee
autocmd BufNewFile,BufRead *.ts set filetype=typescript
autocmd BufNewFile,BufRead Vagrantfile set filetype=ruby
autocmd BufNewFile,BufRead *.json set filetype=javascript

"==================== keybind ====================
"ctrl-c を ESCに置き換え
"ctrl-cとESCは挙動が違う 以下URL参照
"http://d.hatena.ne.jp/yuta84q/20101216/1292508997
inoremap <C-c> <ESC>

imap <C-m> <enter>

"バッファの移動
noremap <C-w>h <C-w><LEFT>
noremap <C-w>j <C-w><DOWN>
noremap <C-w>k <C-w><UP>
noremap <C-w>l <C-w><RIGHT>

"行頭、行末移動
noremap <C-a> ^
noremap <C-e> $
noremap <C-i> <C-a>

"一時ファイルを開く
command! Tmp :edit `=tempname()`

"ヤンクした文字列とカーソル位置の単語を置換する
nnoremap <silent> cy ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
"カーソルが単語内のどこにあってもヤンクした文字列と置換する
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

"<C-c> 2回押しで，検索ハイライトを消去
nnoremap <C-c><C-c> :nohlsearch<CR>

command Vimrc :edit $HOME/.vimrc
command Svimrc :source $HOME/.vimrc

"==================== neocomplcache ====================
"Note: This option must set it in .vimrc(_vimrc). NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

let g:neocomplcache_max_list = 10
let g:neocomplcache_enable_auto_close_preview = 0

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword, for minor languages
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion. Not required if they are already set elsewhere in
" .vimrc
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType python set completeopt-=preview
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"==================== neosnippets ====================
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
    set conceallevel=2 concealcursor=i
endif

let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets, ~/.vim/snippets'
let g:neosnippet#enable_snipmate_compatibility = 1

"==================== syntastic ====================
let g:syntastic_check_on_wq=0
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_signs=1

if has('vim_starting')
    let $PERL5LIB='./lib:./t:./t/inc:'.expand('$PERL5LIB')
endif

"==================== unite.vim ====================
let g:unite_enable_start_insert = 1 "入力モードで開始する
let g:unite_enable_split_vertically = 1 "縦分割で開く
let g:unite_marked_icon = "*"
let g:unite_cursor_line_highlight = "TabLineSel"
let g:unite_abbr_highlight = "TabLine"
let g:unite_data_directory = "~/.unite"
"unite prefix key
"unite mappings
nnoremap ,f :<C-u>Unite file<CR>
nnoremap ,b :<C-u>Unite buffer<CR>
nnoremap ,h :<C-u>Unite file_mru<CR>
nnoremap ,d :<C-u>UniteWithBufferDir file<CR>
nnoremap ,m :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>

" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" 新しいタブで開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-T> unite#do_action('tabopen')

"==================== vimfiler ====================
let g:vimfiler_as_default_explorer=1

"==================== fugitive ====================
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

"==================== operator replace ====================
map R <Plug>(operator-replace)

"==================== VimShell ====================
",vs: シェルを起動
nnoremap <silent> ,vs :VimShell<CR>
",vv: 画面を縦分割してシェルを起動
nnoremap <silent> ,vv :VimShell -split<CR>

"==================== YankRing ====================
let g:yankring_history_dir = expand('$HOME')
let g:yankring_history_file = '.yankring_history'

"==================== indent-guides ====================
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30
let g:indent_guides_guide_size = 1

let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd ctermbg=green
hi IndentGuidesEven ctermbg=green

"==================== vim-funlib ====================
":put! =Random(0,100)
function! Random(a, b)
    return random#randint(a:a, a:b)
endfunction

function! MD5(data)
    return hashlib#md5(a:data)
endfunction

function! Sha1(data)
    return hashlib#sha1(a:data)
endfunction

function! Sha256(data)
    return hashlib#sha256(a:data)
endfunction

"==================== toggle ====================
"+ で切り替え
let g:toggle_pairs = {
    \ 'and': 'or', 'or': 'and',
    \ 'if': 'unless', 'unless': 'if'
    \ }

"==================== jump2pm ====================
noremap fg :call Jump2pm('vne')<Enter>
noremap ff :call Jump2pm('e')<Enter>
noremap fd :call Jump2pm('sp')<Enter>
noremap ft :call Jump2pm('tabe')<Enter>

"==================== ack.vim ====================
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

"==================== easymotion.vim ====================
" ホームポジションに近いキーを使う
let g:EasyMotion_keys='hjklasdfgyuiopqwertnmzxcvbHJKLASDFGYUIOPQWERTNMZXCVB'
" 「m」 + 何かにマッピング
let g:EasyMotion_leader_key="m"
" 1 ストローク選択を優先する
let g:EasyMotion_grouping=1
" カラー設定変更
hi EasyMotionTarget ctermbg=none ctermfg=red
hi EasyMotionShade  ctermbg=none ctermfg=blue

"==================== vim_goshrepl.git ====================
let g:neocomplcache_keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"
let g:gosh_buffer_direction = 'v'
let g:gosh_buffer_width = 80
vmap <CR> <Plug>(gosh_repl_send_block)

"http://d.hatena.ne.jp/aharisu/20120430/1335762494
"GoshREPL    gosh REPLを起動する
"GoshREPLWithBuffer  現在バッファのテキストを全て評価済みの状態でgosh REPLを起動する
"GoshREPLClear   gosh REPLの内容をすべてクリアする
"GoshREPLSend hoge   引数のhogeをGaucheの式としてgosh REPL内で評価する
"まだgosh REPLが起動していない場合は自動的に新しいREPLが起動する
"GoshREPLLines   GoshREPL内で実行したすべての式をリスト表示する

"==================== vim-ref ====================
"http://www.karakaram.com/ref-webdict
"webdictサイトの設定
let g:ref_source_webdict_sites = {
            \   'je': {
            \     'url': 'http://dictionary.infoseek.ne.jp/jeword/%s',
            \   },
            \   'ej': {
            \     'url': 'http://dictionary.infoseek.ne.jp/ejword/%s',
            \   },
            \   'wiki': {
            \     'url': 'http://ja.wikipedia.org/wiki/%s',
            \   },
            \ }
 
"デフォルトサイト
let g:ref_source_webdict_sites.default = 'ej'
 
"出力に対するフィルタ。最初の数行を削除
function! g:ref_source_webdict_sites.je.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.ej.filter(output)
    return join(split(a:output, "\n")[15 :], "\n")
endfunction
function! g:ref_source_webdict_sites.wiki.filter(output)
    return join(split(a:output, "\n")[17 :], "\n")
endfunction

"\rj
nmap <Leader>rj :<C-u>Ref webdict je<Space>
nmap <Leader>re :<C-u>Ref webdict ej<Space>

let g:ref_open = 'vsplit'

"==================== ctrlp.vim ====================
let g:ctrlp_map = '<c-l>'

"==================== vim-over ====================

" over.vimの起動
nnoremap <silent> <Leader>o :OverCommandLine<CR>

" カーソル下の単語をハイライト付きで置換
nnoremap sub :OverCommandLine<CR>%s/<C-r><C-w>//g<Left><Left>

" コピーした文字列をハイライト付きで置換
nnoremap subp y:OverCommandLine<CR>%s!<C-r>=substitute(@0, '!', '\\!', 'g')<CR>!!gI<Left><Left><Left>

