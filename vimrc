set nocompatible              " be iMproved, required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'

" Solarized
Plugin 'altercation/vim-colors-solarized'
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_visibility='normal'
let g:solarized_termtrans=1

" Git Fugitive
Plugin 'tpope/vim-fugitive'

" Vim Airline
Plugin 'bling/vim-airline'
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_enable_branch = 1
let g:airline_enable_syntastic = 1
let g:airline_theme = 'solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
function! AirlineInit()
    let g:airline_section_y = airline#section#create(['ffenc', ' %{strftime("%d/%m %H:%M")}'])
endfunction
if has('gui_running')
    set lazyredraw
endif
autocmd VimEnter * call AirlineInit()

" delimitMate
Plugin 'Raimondi/delimitMate'
let delimitMate_expand_cr=1
let delimitMate_expand_space=1

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" Theme config
set background=dark
colorscheme solarized

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
if has ('win32')
    set guifont=Powerline_Consolas:h9
else
    set guifont=Monaco\ for\ Powerline\ 9
endif
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set number
set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set autoindent
"set hidden		" Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)
