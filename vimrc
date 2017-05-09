" Vim-plug
" Inicializar Vim-plug
 if has("win32") || has("win64")
    call plug#begin('~/vimfiles/plugins')
else
    call plug#begin('~/.config/nvim/plugins')
end

" Solarized
Plug 'altercation/vim-colors-solarized'
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_visibility='normal'
let g:solarized_termtrans=1

" Git Fugitive
Plug 'tpope/vim-fugitive'

" Vim Airline Themes
Plug 'vim-airline/vim-airline-themes'

" Vim Airline
Plug 'vim-airline/vim-airline'
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
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

" Auto-Pairs
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsFlyMode = 0

" Deoplete (autocompletion)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" Vim javascript syntax
Plug 'jelera/vim-javascript-syntax'

" Vim javascript
Plug 'pangloss/vim-javascript'

" Vim indentLine
Plug 'Yggdroot/indentLine'
let g:indentLine_enabled = 1
let g:indentLine_loaded = 1
let g:indentLine_fileTypeExclude = ['sh', 'text']
let g:indentLine_char = "\u22EE"
let g:indentLine_char = "┆"
let g:indentLine_first_char = "\u22EE"

" Vim indent guides
"Plug 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1

" " UltiSnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
let g:UltiSnipsSnippetsDir = "plugins/vim-snippets/UltiSnips"
let g:UltiSnipsExpandTrigger="<C-c><Enter>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

" vim-commentary
Plug 'tpope/vim-commentary'

" Emmet
Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-Z>'

" Inicializar Vim-plug
call plug#end()
filetype plugin indent on

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
if has("win32") || has("win64")
    set guifont=Monaco\ for\ Powerline:h9:cANSI
    "set renderoptions=type:directx,renmode:5
else
    set guifont=Monaco\ for\ Powerline\ 9
endif

" Setear tamaño ventana windows
if has("gui_running")
    set columns=100
    set lines=40
endif

let mapleader = ","
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
set enc=utf8		" Usar juego de caracteres UTF-8
