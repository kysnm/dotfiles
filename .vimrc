set number
" ファイル内の <Tab> が対応する空白の数。
set tabstop=2
" 自動インデントの各段階に使われる空白の数。
set shiftwidth=2
" Insertモードで: <Tab> を挿入するのに、適切な数の空白を使う。（タブをスペースに展開する）
set expandtab
" 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set autoindent
" compatible の機能をオフにします。compatible のオプションを有効にすると、Vimの便利な機能が使えなくなる。 初期値：オン
set nocompatible
" C-h で行をさかのぼって削除
set backspace=2
" 強調表示(色付け)のON/OFF設定。
set term=ansi
syntax on
" ファイル形式の検出を有効化
filetype on
" ファイル形式別インデントのロードを有効化
filetype indent on
" ファイル形式別プラグインのロードを有効化
filetype plugin on

" rails.vim 参考 http://fg-180.katamayu.net/archives/2006/09/02/125150
"" ロードされる特徴のレベルの一般的なコントロール 4 は（すべての普通の特徴を有効にする。推奨）
let g:rails_level=4
"" 新しいRailsアプリケーションが作られたときロードするファイル。
let g:rails_default_file="app/controllers/application.rb"
"" 新しいアプリケーションで使うデータベース。
let g:rails_default_database="mysql"

" rubycomplete.vim
"" FileType settings
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType html set filetype=xhtml
autocmd Filetype html set omnifunc=htmlcomplete#CompleteTags
autocmd Filetype css set omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" autocomplpop.vim
let g:AutoComplPop_CompleteOption = '.,w,b,k'
let g:AutoComplPop_IgnoreCaseOption = 1
autocmd FileType * let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i'
autocmd FileType perl let g:AutoComplPop_CompleteOption = '.,w,b,u,t,k~/.vim/dict/perl.dict'
autocmd FileType ruby let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/ruby.dict'
autocmd FileType html let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'
autocmd FileType javascript let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/javascript.dict'
autocmd FileType erlang let g:AutoComplPop_CompleteOption = '.,w,b,u,t,i,k~/.vim/dict/erlang.dict'

" ポップアップの配色
hi Pmenu guibg=#666666
hi PmenuSel guibg=#8cd0d3 guifg=#666666
hi PmenuSbar guibg=#333333

command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>') 
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>

set backup
set backupdir=$HOME/.vim-backup
let &directory = &backupdir

set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" Window
map <C-W><C-V> :Vexplore!<CR>
map <C-W><C-H> :Hexplore<CR>
map! <C-W><C-V> <Esc>:Vexplore!<CR>
map! <C-W><C-H> <Esc>:Hexplore<CR>

let g:netrw_sort_sequence="[\\/]$,*,\\.\\(mv\\|old\\|cp\\|bak\\|orig\\)[0-9]*[\\/]$,\\.\\(mv\\|old\\|cp\\|bak\\|orig\\)[0-9]*$,\\.o$,\\.info$,\\.swp$,\\.obj$ "

hi Pmenu ctermbg=4
hi PmenuSel ctermbg=1
hi PMenuSbar ctermbg=4

"function! CompleteNewlineSeparete(pairs)
"ruby << EOF
"        row = $curwin.cursor[0]
"        col = $curwin.cursor[1]
"        curline = $curbuf[row]
"        curchar  = curline[col]
"        nextchar = curline[col + 1]
"        pairs = VIM::evaluate("a:pairs")
"        pairs.scan(/.{2}/) {|pair|  # 2文字ごと
"                if curchar == pair[0] && nextchar == pair[1] then
"                        $curbuf[row] = curline[0..(col)]
"                        nl = curline[/^[\t\r\n\f\v]*/]
"                        nl += String.new( curline[(col+1)..-1] )
"                        $curbuf.append(row, nl)
"                        break
"                end
"        }
"EOF
"endfunction
"
"function! NoDoubleClose(pair)
"ruby << EOF
"        row = $curwin.cursor[0]
"        col = $curwin.cursor[1]
"        curline = $curbuf[row]
"        prechar  = curline[col - 1]
"        nextchar = curline[col + 1]
"        pair = VIM::evaluate("a:pair")
"        if prechar == pair[0] && nextchar == pair[1] then
"                $curbuf[row] = curline[0..(col)] + curline[(col+2)..-1]
"                p "ok"
"        end
"EOF
"endfunction
"
"inoremap <Enter> <ESC>:call CompleteNewlineSeparete('{}')<Enter>a<Enter>
"inoremap { {}<LEFT>
"inoremap } }<ESC>:call NoDoubleClose('{}')<Enter>a
"
" 「)」も自動入力
"inoremap <Enter> <ESC>:call CompleteNewlineSeparete('(){}')<Enter>a<Enter>
"inoremap ( ()<LEFT>
"inoremap ) )<ESC>:call NoDoubleClose('()')<Enter>a
"inoremap { {}<LEFT>
"inoremap } }<ESC>:call NoDoubleClose('{}')<Enter>a

set clipboard=unnamed
