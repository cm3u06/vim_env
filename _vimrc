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
	set pythonthreedll=$HOME/Python/Python36-32/python36.dll
	"set pythonthreehome=$HOME/Python/Python39-32
	"let $PATH.=';' . $HOME . '/Python/Python39-32/venv_vim' . ';' . $HOME . '/Python/Python39-32/venv_vim/Scripts'
endif

"================================================================================
" Plugin setup
"================================================================================
" >>>> keyboard setting <<<<
" Change <Leader>
let mapleader = ","

" >>>> EasyGrep <<<<
let EasyGrepRecursive = 1
let EasyGrepSearchCurrentBufferDir = 0

" >>>> undo tree <<<<
fun! CreateDotDir()
	if !isdirectory(expand('~/.undo_history')) 
		call mkdir(expand('~/.undo_history')) 
		echo "create ~/.undo_history folder!"
	endif
endfunc

if !exists("undotree_conf")
	let undotree_conf = 1
	augroup UNDO
		autocmd! BufReadPost *.h,*.c,*.cpp,*.v,*.sv,*.py call ReadUndo()
		autocmd! BufWritePre *.h,*.c,*.cpp,*.v,*.sv,*.py call WriteUndo()
	augroup END
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
let NERDTreeChDirMode=1
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


" >>>> REPL <<<<
let g:repl_program = {
           \   'python': 'ipython',
           \   'python-debug' : 'ipdb3',
           \   'default': 'cmd.exe',
           \   'vim': 'vim -e',
           \   }
"let g:repl_predefine_python = {
"            \   'numpy': 'import numpy as np',
"            \   'matplotlib': 'from matplotlib import pyplot as plt'
"            \   }
"let g:repl_python_pre_launch_command = 'C:\Users\tw51112\PyDev\finlab01\.venv\Scripts\activate'
let g:repl_cursor_down = 1
let g:repl_python_automerge = 1
let g:repl_ipython_version = '7'
let g:repl_output_copy_to_register = "t"
nnoremap <leader>r :REPLToggle<Cr>
nnoremap <leader>e :REPLSendSession<Cr>
autocmd Filetype python nnoremap <C-F12> <Esc>:REPLDebugStopAtCurrentLine<Cr>
autocmd Filetype python nnoremap <C-F10> <Esc>:REPLPDBN<Cr>
autocmd Filetype python nnoremap <C-F11> <Esc>:REPLPDBS<Cr>
let g:repl_position = 3


" >>>> jedi <<<<
"let g:jedi#environment_path = 'C:\Users\tw51112\PyDev\finlab01\.venv'
 

" >>>> reply <<<<
" let g:reply_repls = {
" \ 'python' : [
" \ { -> reply#repl#base('ipython', {
" \   'prompt_start' : '^In \[\d\+]: ',
" \   'prompt_continue' : '^\s\s\s\.\.\.: ',
" \ }) }
" \ ]
" \ }
" 
" 
" let g:reply_termwin_max_height=10
" let g:reply_termwin_max_width=40
" nnoremap <leader>w :ReplSend<cr>
" tnoremap <leader>w :ReplSend<cr>
" vnoremap <leader>w :ReplSend<cr>
" nnoremap <leader>r :ReplStop<cr>
" tnoremap <leader>r :ReplStop<cr>
" vnoremap <leader>r :ReplStop<cr>

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
tnoremap <c-h> <c-w>h
tnoremap <c-j> <c-w>j
tnoremap <c-k> <c-w>k
tnoremap <c-l> <c-w>l

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
nnoremap <leader>d :windo diffthis<CR>

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




""""""""""""""""""""""""""""""""""""""
" Python
""""""""""""""""""""""""""""""""""""""

command! -nargs=1 -bang -complete=file Pyvenv call s:set_python_venv(<q-args>,0)
augroup SET_PYTHON_ENV
	au!
	au  FileType python call s:set_python_venv('',1)
augroup END
function! s:set_python_venv(venv_path,mode=0) abort

	if has('win32')
		let l:path_sep = '\'
		let l:venv_bin_dir = 'Scripts'
	elseif has('unix')
		let l:path_sep = '/'
		let l:venv_bin_dir = 'bin'
	else
		echom "Do not set python venv bin."
		return
	endif

	if a:mode == 0
		"echo a:venv_path
		let l:venv_path = expand(a:venv_path)
	else
		let l:venv_path = expand(input("Enter venv path (q: quit): ", '~', "dir"))
	endif
	let l:venv_path = substitute(l:venv_path, '\(\\\|\/\)\s*$','','g')
	let l:venv_bin_path = l:venv_path . l:path_sep . l:venv_bin_dir
	while l:venv_bin_path == "" || !( l:venv_path ==? 'q' || 
				\ executable(l:venv_bin_path . l:path_sep . 'python') ||
				\ executable(l:venv_path . l:path_sep . 'python')
				\ )
		redraw
		echom l:venv_path . ' is not a valid Python venv path !'
		let l:venv_path = substitute(expand(input("Enter venv path again (q: quit): ", '~', "dir")), '\(\\\|\/\)\s*$','','g')
		if executable(l:venv_path . l:path_sep . 'python')
			let l:venv_bin_path = l:venv_path
		else
			let l:venv_bin_path = l:venv_path . l:path_sep . l:venv_bin_dir
		endif
	endwhile

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	if l:venv_path ==? 'q'
		echohl ErrorMsg 
		echom 'Use \":Pyvenv <path to venv>\" to activate Python environment.'
		echohl None
		return
	else
		echom 'Python venv : ' . l:venv_path
	endif

	if filereadable(l:venv_bin_path . l:path_sep . 'activate')
		let l:venv_activate_path = l:venv_bin_path . l:path_sep . 'activate'
	else
		let l:venv_activate_path = ''
	endif

	"silent execute "!" . l:venv_path . '/Scripts/activate'

	" jedi-vim venv
	let b:jedi_environment_path = l:venv_path

	" vim-repl venv
	let g:repl_python_pre_launch_command = l:venv_activate_path
	let $PATH = l:venv_path . ';' . l:venv_bin_path . ';' . $PATH

	" reply venv
	"let b:reply_repl_ipython_executable = l:venv_path . '/Scripts/ipython'
	"let b:reply_repl_ipython_command_options = ''
	"let b:reply__enable_debug=1

endfunction



""""""""""""""""""""""""""""""""""""""
" Verilog code style
""""""""""""""""""""""""""""""""""""""
augroup VERILOG_PLUG_PORT
  autocmd!
  autocmd BufRead,BufNewFile *.v,*.sv       nnoremap  <leader>ap     vib:EasyAlign/\(\[\s*\)\@<!\<\w\+\>\(\s*]\)\@!/ikl0r2<dlall<CR>vib:EasyAlign/\[.\{-}\]/l4r4><CR>vib:EasyAlign-/\<\w\+\>/l4r1dl<CR>
  autocmd BufRead,BufNewFile *.v,*.sv       nnoremap  <leader>ai     vib:EasyAlign/\./inalr0<CR>vib:EasyAlign/^.\{-}\zs(/all4r1<CR>vib:EasyAlign-/)/all1r1<CR>
  autocmd BufRead,BufNewFile *.v,*.sv       nnoremap  <leader>ip     vib:s/\S\+/.& (&)/<CR>vib:EasyAlign/^.\{-}\zs(/all4r1<CR>vib:EasyAlign-/)/all1r1<CR>
augroup END

