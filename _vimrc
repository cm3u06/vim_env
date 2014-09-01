set nocompatible              " be iMproved, required
filetype off                  " required

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

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'mbbill/undotree'
"Plugin 'Shougo/unite.vim'
Plugin 'szw/vim-ctrlspace'
Plugin 'Kocha/vim-systemc'
Plugin 'mileszs/ack.vim'
"Plugin 'scrooloose/syntastic'
Plugin 'gtags.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

let mapleader = ","

"================================================================================
" Environment setup
"================================================================================
"-------------------- nerdtree
nnoremap <F3> :NERDTreeToggle<CR>

"-------------------- ctrl space
let g:ctrlspace_set_default_mapping=0
"let g:ctrlspace_default_mapping_key="<tab>"
nnoremap <tab> :CtrlSpace<CR><CR>
set guioptions-=e

"-------------------- gtags-cscope
set csprg=$VIM\glo631wb\bin\GTAGS-cscope
set cscopequickfix=s-,c-,d-,i-,t-,e-
nnoremap <leader>ga :silent !gtags<CR>:cs add GTAGS<CR>
"nnoremap <c-]> :execute 'cstag '.expand('<cword>')<CR>
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
"================================================================================
" Environment setup
"================================================================================
"-------------------- window view
autocmd GUIEnter * simalt ~x
set nu
syntax on
colorscheme torte
set guifont=Consolas:h10
set nowrap

"-------------------- encoding
"set encoding=
set fileencoding=utf-8
set fileencodings=utf-8,cp950
set termencoding=utf-8

"-------------------- indent
set expandtab
set shiftwidth=4
set tabstop=4

"-------------------- buffer
set hidden
set nobackup

"-------------------- hot key mapping
nnoremap H ^
nnoremap L $

inoremap jk <esc>
onoremap jk <esc>
cnoremap jk <esc>

"-------------------- move windows
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

"-------------------- key behavior
set backspace=indent,eol,start

"-------------------- search
set incsearch
set hlsearch
let hlstate=0
nnoremap <M-n> :if (hlstate == 0) \| nohlsearch \| else \| set hlsearch \| endif \| let hlstate=1-hlstate<cr>
