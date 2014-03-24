" Vim config file
" Maintener: Adam Jurczyk
" Last Change: 20 mar 2014 00:26:49
"

set nocompatible
set ttyfast

set fileencodings=utf-8,ucs-bom,latin1,latin2,cp1250

" my vim common stuff
set backupdir=~/.vim/tmp,/tmp
set directory=~/.vim/tmp,/tmp

set hidden
set title

set backspace=indent,eol,start
set esckeys

" text formating - tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
set smarttab
set nowrap

" info display
set number
set history=250
set ruler
set showcmd
set showmode
set shortmess=atI

" search
set incsearch
set showmatch
set matchtime=0
set ignorecase
set smartcase

" command line completion
set wildmenu
set wildmode=list:longest,full
set wildignore=*.pyc


" status line
set laststatus=2 "show allways
set statusline=%F\ %m%r%h%w%y[%{&ff}]%=%l,%v\ %P\ %L

" misc
set scrolloff=3
set sidescroll=1
set sidescrolloff=3

set mouse=a
set novisualbell
set noerrorbells

""" syntax highlighting """
syntax on
set background=dark
colorscheme ajur

filetype on
if has("autocmd")
    filetype plugin indent on
else
    set autoindent
endif

""" key mappings """
let mapleader = ","

nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>

" spell
set spelllang=pl,en
map <silent><F7> :setlocal spell!<CR>
imap <silent><F7> <ESC>:setlocal spell!<CR>a


""" plugins """

runtime macros/matchit.vim

