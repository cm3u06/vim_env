set nocompatible              " be iMproved, required
filetype off                  " required

set encoding=utf-8
"================================================================================
" bundle setup
"================================================================================

"let did_plugin_ultisnips=1
set rtp+=$HOME/.vim,$HOME/.vim/after
runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()


filetype plugin indent on


if has('win32unix') || has('win32')
	set pythonthreedll=$HOME/python-3.9.9-embed-win32/python39.dll
endif
 

"================================================================================
" Plugin setup
"================================================================================
" >>>> keyboard setting <<<<
" Change <Leader>
let mapleader = ","

" >>>> EasyGrep <<<<
"let EasyGrepSearchCurrentBufferDir = 0

" >>>> undo tree <<<<
fun! CreateDotDir()
	if !isdirectory(expand('~/.undo_history')) 
		call mkdir(expand('~/.undo_history')) 
		echo "create ~/.undo_history folder!"
	endif
endfunc

if !exists("undotree_conf")
	let undotree_conf = 1
	"autocmd FileType c,cpp,systemc,verilog call ReadUndo()
	"autocmd FileType c,cpp,systemc,verilog call WriteUndo()
	autocmd! BufReadPost *.h,*.c,*.cpp,*.v,*.sv,*.py call ReadUndo()
	autocmd! BufWritePre *.h,*.c,*.cpp,*.v,*.sv,*.py call WriteUndo()
endif
func! ReadUndo()
	let undo_file = expand('~'). '/.undo_history/' . substitute(expand('%:p'),'/','_','g') . '.undo'
	if filereadable(fnameescape(undo_file))
		"echo undo_file
		silent! execute 'rundo ' . fnameescape(undo_file)
	endif
endfunc
func! WriteUndo()
	let undo_file = expand('~'). '/.undo_history/' . substitute(expand('%:p'),'/','_','g') . '.undo'
	call CreateDotDir()
	silent! execute 'wundo ' . fnameescape(undo_file)
endfunc
" tree node shape.
let g:undotree_TreeNodeShape = 'o'
" split window location, could also be botright,
let g:undotree_WindowLayout = 'botright'
nmap <F5> :UndotreeToggle<CR>

" >>>> easy motion <<<<
"let g:EasyMotion_leader_key='\'

" >>>> surround <<<<
"imap s( <Plug>Isurround)
"imap s{ <Plug>Isurround}
"imap s[ <Plug>Isurround]
"imap s< <Plug>Isurround>
"imap s" <Plug>Isurround"
"imap s' <Plug>Isurround'

" >>>> nerd-tree <<<<
let NERDTreeChDirMode=2
let NERDTreeShowHidden=1
nmap <F3> :NERDTreeToggle %:p:h<CR>




" >>>> ultisnips <<<<
let g:UltiSnipsUsePythonVersion = 3
let g:UltiSnipsExpandTrigger          =    "<tab>"
let g:UltiSnipsListSnippets           =    "<c-tab>"
let g:UltiSnipsJumpForwardTrigger     =    "<tab>"
let g:UltiSnipsJumpBackwardTrigger    =    "<s-tab>"


" >>>> FZF <<<<
nnoremap <F4> :FZF<CR>
"let g:fzf_action = {
"			\ 'ctrl-t': 'tab split',
"			\ 'ctrl-x': 'split',
"			\ 'ctrl-v': 'vsplit' }
"let g:fzf_history_dir=1


" >>>> leaderf <<<<
let g:Lf_UseVersionControlTool=0
let g:Lf_WildIgnore = {
			\ 'dir': ['.svn','.git','.hg'],
			\ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]']
			\}
let g:Lf_MaxCount = 100000

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
"autocmd! BufWritePost _vimrc source D:\Vim\_vimrc

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
set guifont=Consolas:h14
set nowrap
autocmd GUIEnter * simalt ~x
"set cursorline
colorscheme torte
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
nnoremap <leader>h :silent :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<cr>

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


