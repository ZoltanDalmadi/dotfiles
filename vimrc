" =============================== Functions =================================

" Detect platform
silent function! WINDOWS()
    return (has('win16') || has('win32') || has('win64'))
endfunction

" Detect GUI
silent function! GUI()
    return (has('gui_running'))
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

" ============================= Plugins (vundle) ============================

set nocompatible
filetype off

if WINDOWS()
    set rtp+=$VIM/bundle/vundle
    let vundle_path=expand($VIM.'/bundle')
else
    set rtp+=~/.vim/bundle/vundle/
    let vundle_path=expand($HOME.'/.vim/bundle')
endif

" First use (detects if vundle is installed, if not, installs it)
let vundle_readme=expand(vundle_path.'/vundle/README.md')

if !filereadable(vundle_readme)
    let vundle_not_installed = 1

    echo "Vundle is going to be installed."
    echo "Please run \":PluginInstall\" afterwards, and restart VIM."
    echo ""

    if WINDOWS()
        silent execute '!md '.vundle_path
        let vundle_slash = '\'
    else
        silent execute '!mkdir -p '.vundle_path
        let vundle_slash = '/'
    endif

    silent execute '!git clone https://github.com/gmarik/Vundle.vim '
                    \.vundle_path.vundle_slash.'vundle'
endif

call vundle#begin(vundle_path)

Plugin 'gmarik/vundle'

" Sensible defaults
Plugin 'tpope/vim-sensible'

" Color schemes
Plugin 'morhetz/gruvbox'
Plugin 'nanotech/jellybeans.vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'altercation/vim-colors-solarized'
Plugin 'NLKNguyen/papercolor-theme'
Plugin 'chriskempson/base16-vim'
Plugin 'zsoltf/vim-maui'
Plugin 'zsoltf/vim-maui-airline'
Plugin 'jordwalke/flatlandia'
Plugin 'MaxSt/FlatColor'
Plugin 'endel/vim-github-colorscheme'
Plugin 'joshdick/onedark.vim'
Plugin 'joshdick/airline-onedark.vim'

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
if WINDOWS()
    Plugin 'ervandew/supertab'
endif

" Syntax bundles
Plugin 'mattn/emmet-vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'beyondmarc/glsl.vim'
Plugin 'jrozner/vim-antlr'

" Useful for C/C++
Plugin 'majutsushi/tagbar'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'vim-scripts/a.vim'
Plugin 'vim-scripts/DoxygenToolkit.vim'
if WINDOWS()
    Plugin 'Rip-Rip/clang_complete'
else
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'edkolev/tmuxline.vim'
endif

" Fast yaml
Plugin 'stephpy/vim-yaml'

" Other utils
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'Raimondi/delimitMate'
Plugin 'godlygeek/tabular'
Plugin 'tomtom/tcomment_vim'
Plugin 'oblitum/rainbow'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'justinmk/vim-sneak'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'AndrewRadev/sideways.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'rking/ag.vim'
Plugin 'moll/vim-bbye'

call vundle#end()
filetype plugin indent on

" ============================== Basic options ==============================

set autochdir          " Change directory to the current buffer when opening
set autowrite          " Auto save before commands like next and make
set ttyfast            " Smoother changes
set cursorline         " Highlight current line
set relativenumber     " Show line numbers relative to cursor
set number             " Show line numbers
set expandtab          " Convert tabs to spaces
set shiftwidth=4       " Number of spaces in autoindent
set tabstop=4          " Tab is 4 spaces wide
set softtabstop=4      " Number of spaces to jump when tabbing or backspacing
set nobackup           " Disable backups
set hlsearch           " Highlight search matches
set encoding=utf-8     " Editor encoding
set fileencoding=utf-8 " Save files with utf8 encoding

" Enable mouse (for terminal)
if has('mouse')
  set mouse=a
endif

" set , as mapleader
let mapleader = ","

" ================================ GUI setup ================================

if GUI()
    " set font depending on platform
    if WINDOWS()
        set guifont=Consolas:h11:cEASTEUROPE
    else
        set guifont=Fira\ Mono\ 11
    endif

    set guiheadroom=0         " Stretch gui to full window
    set columns=210           " Default width
    set lines=61              " Default height
    set guioptions-=m         " Hide menubar
    set guioptions-=T         " Hide toolbar
    set guioptions-=r         " Hide right scrollbar
    set guioptions-=L         " Hide left scrollbar
    set guicursor=a:blinkon0  " Disable cursor blink
endif

" ============================ Colorscheme setup ============================

set background=dark

if !exists("vundle_not_installed")
    let g:gruvbox_italicize_comments=0
    colorscheme gruvbox
else
    colorscheme ron
endif

" ============================= Plugin settings =============================

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" tmuxLine
let g:tmuxline_separators = { 'left' : '',
                            \ 'left_alt': '>',
                            \ 'right' : '',
                            \ 'right_alt' : '<',
                            \ 'space' : ' '}

" SuperTab
if WINDOWS()
    let g:SuperTabDefaultCompletionType = "context"
endif

set completeopt=menuone,longest

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" sneak
let g:sneak#streak = 1
let g:sneak#s_next = 1

if WINDOWS()
" clang_complete
    let g:clang_hl_errors = 0
    let g:clang_snippets = 1
    let g:clang_snippets_engine = 'ultisnips'
else
" YouCompleteMe
    let g:ycm_key_list_select_completion=[]
    let g:ycm_key_list_previous_completion=[]
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
endif

" Syntastic
let g:syntastic_cpp_compiler_options="-std=c++14"

" ============================== Autocommands ===============================

if has("autocmd")
    " Filetype specific indentations
    autocmd FileType html setlocal ts=2 sts=2 sw=2
    autocmd FileType css setlocal ts=2 sts=2 sw=2
    autocmd FileType cpp setlocal cindent ts=2 sts=2 sw=2
    autocmd FileType c setlocal cindent ts=2 sts=2 sw=2
    autocmd FileType hpp setlocal cindent ts=2 sts=2 sw=2
    autocmd FileType h setlocal cindent ts=2 sts=2 sw=2
    autocmd FileType java setlocal cindent ts=2 sts=2 sw=2

    " Strip trailing whitespace before saving
    autocmd BufWritePre * call StripTrailingWhitespace()

    " Format C/C++ source codes with astyle after save
    autocmd BufWritePost *.[ch]p\\\{,2\} silent !astyle -nq %

    " For Java also, with different style
    autocmd BufWritePost *.java silent !astyle --style=java -nq %

    " Omnicomplete
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python set omnifunc=pythoncomplete#Complete
endif

" =============================== Key bindings ==============================

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

noremap <S-UP> <NOP>
noremap <S-DOWN> <NOP>
