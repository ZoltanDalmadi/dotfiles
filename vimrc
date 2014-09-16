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

" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'

" Airline & Tmux
Plugin 'bling/vim-airline'
Plugin 'edkolev/tmuxline.vim'

" Syntax bundles
Plugin 'digitaltoad/vim-jade'
Plugin 'mattn/emmet-vim'
Plugin 'slim-template/vim-slim'

" Useful for C/C++
Plugin 'WolfgangMehner/c.vim'
Plugin 'majutsushi/tagbar'

" Fast yaml
Plugin 'stephpy/vim-yaml'

" Other utils
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-surround'
Plugin 'jiangmiao/auto-pairs'
Plugin 'godlygeek/tabular'
Plugin 'Yggdroot/indentLine'
Plugin 'tomtom/tcomment_vim'
Plugin 'vim-scripts/hexHighlight.vim'
Plugin 'chrisbra/NrrwRgn'
Plugin 'oblitum/rainbow'
Plugin 'justinmk/vim-sneak'

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

" ================================ GUI setup ================================

if GUI()
    " set font depending on platform
    if WINDOWS()
        set guifont=Tamsyn7x14:h9:cOEM
    else
        set guifont=Tamsyn\ 10.5
    endif

    set guiheadroom=0         " Stretch gui to full window
    set columns=120           " Default width
    set lines=60              " Default height
    set guioptions=ac         " Auto clipboard
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
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.tmuxline"

" tmuxLine
let g:tmuxline_separators = { 'left' : '',
                            \ 'left_alt': '>',
                            \ 'right' : '',
                            \ 'right_alt' : '<',
                            \ 'space' : ' '}

" indentLine
let g:indentLine_enabled = 0
let g:indentLine_char = '│'
let g:indentLine_faster = 1

" SuperTab
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" sneak
let g:sneak#streak = 1

" ============================== Autocommands ===============================

if has("autocmd")
    " Filetype specific indentations
    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab
    autocmd FileType cpp setlocal cindent ts=2 sts=2 sw=2 fileformat=unix
    autocmd FileType c setlocal cindent ts=2 sts=2 sw=2 fileformat=unix
    autocmd FileType java setlocal cindent ts=2 sts=2 sw=2 fileformat=unix
    autocmd FileType python setlocal fileformat=unix

    " Strip trailing whitespace before saving
    autocmd BufWritePre * call StripTrailingWhitespace()

    " Format C/C++/C# source codes with astyle after save
    autocmd BufWritePost *.[ch][p\\\{,2\}s] silent !astyle -nq %

    " For Java also, with different style
    autocmd BufWritePost *.java silent !astyle --style=java -nq %

    " Omnicomplete
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType cpp set omnifunc=ccomplete#Complete
    autocmd FileType c set omnifunc=ccomplete#Complete
    autocmd FileType python set omnifunc=pythoncomplete#Complete
endif

" =============================== Key bindings ==============================

" Buffers and tabs
nnoremap <F5> :bp<CR>
nnoremap <A-F5> :sbp<CR>
nnoremap <S-F5> :vert sbp<CR>
nnoremap <F6> :bn<CR>
nnoremap <A-F6> :sbn<CR>
nnoremap <S-F6> :vert sbn<CR>
nnoremap <F7> :tabprevious<CR>
nnoremap <F8> :tabnext<CR>

" requires vim-csupport
nnoremap <F9> :Make<CR>

" Easier increment/decrement
nnoremap + <C-a>
nnoremap <kPlus> <C-a>
nnoremap - <C-x>
nnoremap <kMinus> <C-x>

" Toggle Tagbar
nnoremap <F11> :TagbarToggle<CR>

" Toggle NERDTree
nnoremap <F10> :NERDTreeToggle<CR>

" Moving lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-DOWN> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
nnoremap <A-UP> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
