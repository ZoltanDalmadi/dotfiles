" =============================== Functions =================================

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

" Needed for deoplete
function! DoRemote(arg)
	UpdateRemotePlugins
endfunction

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

" Useful for C/C++
Plug 'majutsushi/tagbar'
Plug 'octol/vim-cpp-enhanced-highlight'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'carlitux/deoplete-ternjs'
Plug 'othree/yajs.vim', { 'for': 'javascript' }
Plug 'gavocanov/vim-js-indent'

" Other utils
Plug 'gcmt/taboo.vim'
Plug 'itchyny/lightline.vim'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'scrooloose/syntastic'
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/sideways.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'justinmk/vim-sneak'
Plug 'Raimondi/delimitMate'
Plug 'leafgarland/typescript-vim'
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

" set , as mapleader
let mapleader = ","

" Use deoplete.
let g:deoplete#enable_at_startup = 1
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0

set background=dark
colorscheme PaperColor
let g:lightline = {}
let g:lightline.colorscheme = 'PaperColor'

" sneak
let g:sneak#streak = 1
let g:sneak#s_next = 1

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'

" ============================== Autocommands ===============================

" Strip trailing whitespace before saving
autocmd BufWritePre * call StripTrailingWhitespace()
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

let g:tern_show_argument_hints = 'on_hold'
let g:tern_show_signature_in_pum = 1
autocmd FileType html,javascript setlocal ts=2 sw=2
autocmd FileType javascript setlocal ts=2 sw=2 omnifunc=tern#Complete

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
