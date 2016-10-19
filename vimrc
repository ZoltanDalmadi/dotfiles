" =============================== Functions =================================

" Detect platform
silent function! WINDOWS()
	return (has('win16') || has('win32') || has('win64'))
endfunction

" Strip trailing whitespace
function! StripTrailingWhitespace()
	" Preparation: save last search, and cursor position.
	let _s=@/
	let l = line(".")
	let c = col(".")
	" do the business:
	%s/\s\+$//e
	" Cleanup: restore previous search history, and cursor position
	let @/=_s
	call cursor(l, c)
endfunction

" ================================ Plugins ==================================
call plug#begin()

" Color schemes
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'NLKNguyen/papercolor-theme'
Plug 'chriskempson/base16-vim'
Plug 'zsoltf/vim-maui'
Plug 'jordwalke/flatlandia'
Plug 'MaxSt/FlatColor'
Plug 'joshdick/onedark.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'

" Useful for C/C++
Plug 'majutsushi/tagbar'
Plug 'octol/vim-cpp-enhanced-highlight'

" Completion
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'gavocanov/vim-js-indent'

" Other utils
Plug 'gcmt/taboo.vim'
Plug 'itchyny/lightline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/sideways.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'justinmk/vim-sneak'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

call plug#end()

" ============================== Basic options ==============================

set autochdir          " Change directory to the current buffer when opening
set autowrite          " Auto save before commands like next and make
set autoread           " Auto read changes to buffer
set cursorline         " Highlight current line
set relativenumber     " Show line numbers relative to cursor
set number             " Show line numbers
set shiftwidth=4       " Number of spaces in autoindent
set tabstop=4          " Tab is 4 spaces wide
set nobackup           " Disable backups
set hlsearch           " Highlight search matches
set encoding=utf-8     " Editor encoding
set fileencoding=utf-8 " Save files with utf8 encoding

" set , as mapleader
let mapleader = ","

" ================================ GUI setup ================================

if WINDOWS()
	set guifont=InputMonoCondensed:h12:cEASTEUROPE
else
	set guifont=Input\ Mono\ Condensed\\,\ Condensed\ 12
endif

set guiheadroom=0         " Stretch gui to full window
set columns=210           " Default width
set lines=61              " Default height
set guioptions-=m         " Hide menubar
set guioptions-=T         " Hide toolbar
set guioptions-=e         " Console style tab bar
set guioptions-=r         " Hide right scrollbar
set guioptions-=L         " Hide left scrollbar
set guicursor=a:blinkon0  " Disable cursor blink

set background=dark
colorscheme PaperColor

" ============================ Plugin settings ==============================

" lightline
let g:lightline = {}
let g:lightline.colorscheme = 'PaperColor'

" sneak
let g:sneak#streak = 1
let g:sneak#s_next = 1

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Syntastic
let g:syntastic_javascript_checkers = ['eslint']

" supertab
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest

" ============================== Autocommands ===============================

" Strip trailing whitespace before saving
autocmd BufWritePre * call StripTrailingWhitespace()

" html, css and js files have a tab width of 2
autocmd FileType html,css,javascript setlocal ts=2 sw=2

" ============================== Key Commands ===============================

" type ,ev to edit vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>

" Buffers and tabs
nnoremap <F5> :bp<CR>
nnoremap <A-F5> :sbp<CR>
nnoremap <S-F5> :vert sbp<CR>
nnoremap <F6> :bn<CR>
nnoremap <A-F6> :sbn<CR>
nnoremap <S-F6> :vert sbn<CR>
nnoremap <F7> :tabprevious<CR>
nnoremap <F8> :tabnext<CR>

" Toggle Tagbar
nnoremap <F11> :TagbarToggle<CR>

" Toggle NERDTree
nnoremap <F10> :NERDTreeToggle<CR>

" Moving lines
nnoremap <C-j> :m .+1<CR>==
nnoremap <A-DOWN> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
nnoremap <A-UP> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Unbind Shift-Up and Shift-Down
noremap <S-UP> <NOP>
noremap <S-DOWN> <NOP>
