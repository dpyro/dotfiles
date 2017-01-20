set nocompatible
filetype indent plugin on
syntax on

set shiftwidth=4
set softtabstop=4
set expandtab
set syntax
set showbreak=↪
set wrap
set backspace=indent,eol,start
set autoindent
set nostartofline
set laststatus=2
set confirm
set visualbell
set t_vb=
set mouse=a
set cmdheight=2
set number
set notimeout ttimeout ttimeoutlen=200
set hidden
set wildmenu
set showcmd
set hlsearch
set ignorecase
set smartcase

colorscheme desert

map Y y$

" Redraw screen also disables the search highlighting.
nnoremap <C-L> :nohl<CR><C-L>

" Reload .vimrc after file write.
augroup vimrc_reload
  autocmd!
  autocmd BufWritePost ~/.vimrc source ~/.vimrc
augroup END

