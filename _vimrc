set nocompatible              " be iMproved, required
filetype off                  " required

" >>>> Encoding setting <<<<
set encoding=utf-8
setglobal fileencoding=utf-8
set fileencodings=utf-8,big5,gbk,latin1
set termencoding=utf-8

"================================================================================
" Vundle setup
"================================================================================
" set the runtime path to include Vundle and initialize
set rtp+=~/vimfiles/bundle/Vundle.vim/
let path='~/vimfiles/bundle'
call vundle#begin(path)
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
"Plugin 'tpope/vim-fugitive'

call vundle#end()
filetype plugin indent on    " required
Plugin 'szw/vim-ctrlspace'
Plugin 'vim-scripts/EasyGrep'
Plugin 'nanotech/jellybeans.vim'
Plugin 'matchit.zip'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'
Plugin 'Kocha/vim-systemc'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'mbbill/undotree'
Plugin 'sgeb/vim-matlab'
Plugin 'itchyny/lightline.vim'
Plugin 'Raimondi/delimitMate'
Plugin 'vim-scripts/vcscommand.vim'
Plugin 'MattesGroeger/vim-bookmarks'
"Plugin 'easymotion'
"Plugin 'easytags'
"Plugin 'repeat'
"Plugin 'shell'
"Plugin 'tpope/vim-fugitive'
"Plugin 'Shougo/unite.vim'
"Plugin 'mileszs/ack.vim'
"Plugin 'scrooloose/syntastic'
" user maintain
Plugin 'Valloric/YouCompleteMe', {'pinned': 1}
Plugin 'Gtags', {'pinned': 1}
 

"================================================================================
" Plugin setup
"================================================================================
" >>>> keyboard setting <<<<
" Change <Leader>
let mapleader = ","

" >>>> create .dotfile <<<<
fun! CreateDotDir()
	cd %:p:h
	if !isdirectory('./.dotfiles') 
		call mkdir('./.dotfiles') 
		echo "create ./.dotfiles folder!"
	endif
endfunc

" >>>> vim-bookmarks <<<<
let g:bookmark_auto_close = 1
nmap mm <Plug>BookmarkToggle
nmap ma <Plug>BookmarkAnnotate
nmap ms <Plug>BookmarkShowAll
nmap m[ <Plug>BookmarkPrev
nmap m] <Plug>BookmarkNext
nmap mc <Plug>BookmarkClear
nmap mC <Plug>BookmarkClearAll

" >>>> EasyGrep <<<<
let EasyGrepSearchCurrentBufferDir = 0

" >>>> easytags <<<<
"let g:easytags_python_enabled = 1
"let g:easytags_include_members = 1
"let g:easytags_on_cursorhold = 0
""let g:easytags_updatetime_min = 4000
"if !exists("easytags_conf")
"	let easytags_conf = 1
"	autocmd Filetype c,cpp,verilog call CreateTags()
"endif
"func! CreateTags()
"	call CreateDotDir()
"	set tags =./.dotfiles/tags;
"	let g:easytags_dynamic_files=2
"endfunc
"highlight ClassMember ctermfg=none guifg=#ffff88
"highlight link cMember ClassMember

" >>>> undo tree <<<<
"if has("persistent_undo")
    "set undodir ='c:\\Documents\ and\ Settings\\902092'
    "set undofile
"endif
if !exists("undotree_conf")
	let undotree_conf = 1
	"autocmd FileType c,cpp,systemc,verilog call ReadUndo()
	"autocmd FileType c,cpp,systemc,verilog call WriteUndo()
	autocmd! BufReadPost *.h,*.c,*.cpp,*.v call ReadUndo()
	autocmd! BufWritePre *.h,*.c,*.cpp,*.v call WriteUndo()
endif
func! ReadUndo()
	if filereadable(expand('%:h'). '/.dotfiles/' . expand('%:t') . '.undo')
		silent! rundo %:h/.dotfiles/%:t.undo
	endif
endfunc
func! WriteUndo()
	call CreateDotDir()
	silent! wundo %:h/.dotfiles/%:t.undo
endfunc
" tree node shape.
let g:undotree_TreeNodeShape = 'o'
" split window location, could also be botright,
let g:undotree_WindowLayout = 'botright'
nmap <F10> :UndotreeToggle<CR>

" >>>> easy motion <<<<
"let g:EasyMotion_leader_key='\'

" >>>> surround <<<<
imap s( <Plug>Isurround)
imap s{ <Plug>Isurround}
imap s[ <Plug>Isurround]
imap s< <Plug>Isurround>
imap s" <Plug>Isurround"
imap s' <Plug>Isurround'

" >>>> nerd-tree <<<<
let NERDTreeChDirMode=2
nmap <F3> :NERDTreeToggle %:p:h<CR>

" >>>> YouCompleteMe <<<<
let g:ycm_allow_changing_updatetime = 0

" >>>> tagbar <<<<
let g:tagbar_width = 30
autocmd Filetype c,cpp,verilog nnoremap <F5> :TagbarToggle<CR>

" >>>> ctrlspace <<<<
let g:ctrlspace_default_mapping_key = "<tab>"
let g:ctrlspace_unicode_font = 1

" >>>> gtags-cscope <<<<
set cscopequickfix=s-,c-,d-,i-,t-,e-
set cscopetag
let g:GtagsCscope_Auto_Map = 1
if g:GtagsCscope_Auto_Map == 0
  "nnoremap <C-\>a :silent !gtags<CR>:cs add GTAGS<CR>
  "set csprg=$VIM\glo631wb\bin\GTAGS-cscope
  nnoremap <leader>gg :execute 'cscope find g '.expand('<cword>')<CR>
  nnoremap <leader>gs :execute 'cscope find s '.expand('<cword>')<CR>
  nnoremap <leader>gc :execute 'cscope find c '.expand('<cword>')<CR>
  nnoremap <leader>gt :execute 'cscope find t '.expand('<cword>')<CR>
  nnoremap <leader>gf :execute 'cscope find f '.expand('<cword>')<CR>
  nnoremap <leader>gi :execute 'cscope find i '.expand('<cword>')<CR>
  vnoremap <leader>gg <ESC>:execute 'cscope find g '.GetVisualSelection()<CR>
  vnoremap <leader>gs <ESC>:execute 'cscope find s '.GetVisualSelection()<CR>
  vnoremap <leader>gc <ESC>:execute 'cscope find c '.GetVisualSelection()<CR>
  vnoremap <leader>gt <ESC>:execute 'cscope find t '.GetVisualSelection()<CR>
  vnoremap <leader>gf <ESC>:execute 'cscope find f '.GetVisualSelection()<CR>
  vnoremap <leader>gi <ESC>:execute 'cscope find i '.GetVisualSelection()<CR>
  function! GetVisualSelection()
    let [s:lnum1, s:col1] = getpos("'<")[1:2]
    let [s:lnum2, s:col2] = getpos("'>")[1:2]
    let s:lines = getline(s:lnum1, s:lnum2)
    let s:lines[-1] = s:lines[-1][: s:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let s:lines[0] = s:lines[0][s:col1 - 1:]
    return join(s:lines, ' ')
  endfunction
endif

"================================================================================
" Environment setup
"================================================================================
" Quick timeouts on key combinations.
set timeoutlen=300

set backspace=indent,eol,start " allow backspacing over everything in insert mode

" Move inline
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
onoremap H ^
onoremap L $

" Move between windows
noremap <c-h> <c-w>h
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-l> <c-w>l

" ` is more useful than ' but less accessible.
nnoremap ' `
nnoremap ` '

" Alternatives to ESC:
inoremap jk <ESC>
onoremap jk <ESC>
cnoremap jk <ESC>
   
" Fix command typos (stolen from Adam Katz)
"nmap ; :
nnoremap Y y$

" >>>> file setting <<<<
set autoread			" auto read when file is changed from outside
" auto reload vimrc when editing it
autocmd! BufWritePost _vimrc source ~\_vimrc

" >>>> Buffer setting <<<<
" cd to current working directory
cnoremap cd. cd %:p:h
" Allow switching edited buffers without saving
set hidden

" >>>> Tab page setting <<<<
set tabpagemax=100
set guioptions-=e
"set guitablabel=%N.\ %t

" >>>> Backup setting <<<<
set nobackup
" Auto-backup files and .swp files don't go to pwd
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" >>>> View setting <<<<
set number
set guifont=Consolas:h10
set nowrap
autocmd GUIEnter * simalt ~x
"set cursorline
colorscheme jellybeans
syntax on

" >>>> Command-line setting <<<<
set history=1000
set shortmess=atI
"set visualbell
set noerrorbells
"set printoptions=paper:letter
" Bash-like filename completion
set wildmenu
"set wildmode=list:longest
set wildignore=*.o,*.fasl

" >>>> Statusline setting <<<<
set ruler
set showcmd

" >>>> Match setting <<<<
set showmatch
set matchtime=0

" >>>> Indent setting <<<<
command IndentSpace2 set tabstop=2 softtabstop=0 shiftwidth=2 expandtab fdm=marker fdo-=search formatoptions+=j textwidth=110 "autoindent
command IndentTab4 set tabstop=4 softtabstop=0 shiftwidth=4 noexpandtab fdm=marker fdo-=search formatoptions+=j textwidth=110 "autoindent
autocmd! Filetype cpp,c,verilog IndentSpace2
set listchars=tab:>-,trail:.,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" >>>> Search setting <<<<
set hlsearch
set incsearch
set ignorecase
set smartcase
"nmap <silent> <M-n> :silent :nohlsearch<CR>
let hlstate=0
nnoremap <M-n> :silent :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<cr>

" >>>> scroll setting <<<<
set sidescroll=1
set sidescrolloff=3

"nnoremap <C-s> 70zh
"nnoremap <C-e> 70zl
"vnoremap <C-s> 70zh
"vnoremap <C-e> 70zl

" >>>> Diff setting <<<<
set diffopt=filler,vertical,iwhite,context:0
nnoremap <F12> :vert sbnext<CR>:windo diffthis<CR>
nnoremap <M-F12> :set guioptions+=b<CR>:set scrollopt+=hor<CR>:vsp<CR>:set scrollbind<CR><C-L>:bn<CR>:set scrollbind<CR><C-H>

" >>>> Tags setting <<<<
""nnoremap tn :tn<CR>
""nnoremap tp :tp<CR>

" >>>> Special functions <<<<
" hex <-> decimal
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction

" integral arithmetic
function! CalculateCursor(x, operator)
  let p = @/
  try
    silent exe "s%-\\?\d*\\%#\\d\\+%\\=submatch(0) " . a:operator . " a:x%"
    exe "normal \<C-O>"
  catch /^Vim\%((\a\+)\)\=:E486/
    try
      silent exe "normal /\\%#.\\{-}\\zs\\d\\+/b\<CR>"
      exe "s%-\\?\d*\\%#\\d\\+%\\=submatch(0) " . a:operator . " a:x%"
      exe "normal \<C-O>"
    catch /^Vim\%((\a\+)\)\=:E486/
    endtry
  finally
    let @/ = p
  endtry
endfunction

"noremap <kMinus> <C-X>
vnoremap <silent><C-X> :<C-U>'<,'>call CalculateCursor(v:count1, "-")<CR>:noh<CR>gv
"noremap <kPlus> <C-A>
vnoremap <silent><C-A> :<C-U>'<,'>call CalculateCursor(v:count1, "+")<CR>:noh<CR>gv
noremap <silent><C-S> :<C-U>call CalculateCursor(v:count1, "*")<CR>
vnoremap <silent><C-S> :<C-U>'<,'>call CalculateCursor(v:count1, "*")<CR>:noh<CR>gv
noremap <silent><C-C> :<C-U>call CalculateCursor(v:count1, "/")<CR>
vnoremap <silent><C-C> :<C-U>'<,'>call CalculateCursor(v:count1, "/")<CR>:noh<CR>gv

