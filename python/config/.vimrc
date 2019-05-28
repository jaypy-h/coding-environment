set nocompatible               " required
filetype off                   " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'                                   " Code Folding
Plugin 'vim-scripts/indentpython.vim'                           " Auto-Indentation
Plugin 'Valloric/YouCompleteMe'                                 " Auto-Complete
Plugin 'vim-syntastic/syntastic'                                " check your syntax on each save
Plugin 'nvie/vim-flake8'                                        " PEP 8 checking
Plugin 'jnurmine/Zenburn'                                       " Color Schemes
Plugin 'altercation/vim-colors-solarized'                       " Color Schemes
Plugin 'tomasr/molokai'                                         " Color Schemes
Plugin 'nanotech/jellybeans.vim'                                " Color Schemes
Plugin 'yosiat/oceanic-next-vim'                                " Color Schemes
Plugin 'scrooloose/nerdtree'                                    " File Browsing
Plugin 'jistr/vim-nerdtree-tabs'                                " File Browsing using tab
Plugin 'kien/ctrlp.vim'                                         " Super Searching
Plugin 'tpope/vim-fugitive'                                     " Git Integration
Plugin 'airblade/vim-gitgutter'                                 "
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'} " Powerline
Plugin 'vim-airline/vim-airline'                                " Status bar (powerline)
Plugin 'vim-airline/vim-airline-themes'                         " Status bar theme (powerline)
Plugin 'jeetsukumaran/vim-buffergator'                          " Select and switch between buffers
Plugin 'shime/vim-livedown'                                     " Markdown

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)

" ...

" All of your Plugins must be added before the following line
call vundle#end()              " required
filetype plugin indent on      " required

" Change leader key to ","
:let mapleader=","

set cursorline                 " Emphasize line with cursor
set backspace=indent,eol,start
set showmatch                  " Emphasize matched bracket
set autowrite                  " Save automatically when the other file open
set autoread                   " Load automatically when the file modified in external
set hlsearch                   " Emphasize search keyword
set smartcase                  " Case sensitive search
"set ignorecase                 " Case insensitive search

" ======================================
" Split Layouts
" ======================================
set splitbelow
set splitright

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" ======================================
" Code Folding
" ======================================
" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za

" Try this if you want to see the docstrings for folded code
let g:SimpylFold_docstring_preview=1

if has("autocmd")
    " ======================================
    " python indentation
    " ======================================
    autocmd bufnewfile,bufread *.py
        \ set tabstop=4     |
        \ set softtabstop=4 |
        \ set shiftwidth=4  |
        \ set textwidth=120 |
        \ set expandtab     |
        \ set autoindent    |
        \ set fileformat=unix

    " ======================================
    " markdown indentation
    " ======================================
    autocmd bufnewfile,bufread *.md
        \ set tabstop=4     |
        \ set softtabstop=4 |
        \ set shiftwidth=4  |
        \ set textwidth=120 |
        \ set expandtab     |
        \ set autoindent    |
        \ set fileformat=unix

    " ======================================
    " javascript, html and css indentation
    " ======================================
    autocmd bufnewfile,bufread *.js, *.html, *.css
        \ set tabstop=2     |
        \ set softtabstop=2 |
        \ set shiftwidth=2

    " python config
    autocmd bufnewfile,bufread *.py setfiletype python
    autocmd filetype python nmap <f2> <esc>:wa!<cr>:!python %<cr>

    " set last cursor position
    autocmd bufreadpost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \     exe "normal! g`\"" |
        \ endif
endif
 
" ======================================
" Flagging Unnecessary Whitespace
" ======================================
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" ======================================
" UTF-8 Support
" ======================================
set encoding=utf-8
"set fileencodings=utf-8,cp949,default,latin1
"set termencoding=utf-8

" ======================================
" Auto-Complete
" ======================================
let g:ycm_autoclose_preview_window_after_completion=1
"nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<cr>
nnoremap <leader>g :YcmCompleter GoTo<cr>
"nnoremap <leader>i :YcmCompleter GoToImprecise<cr>
nnoremap <leader>d :YcmCompleter GoToDeclaration<cr>
"nnoremap <leader>d :YcmCompleter GoToDefinition<cr>
"nnoremap <leader>d :YcmCompleter GoToDefinitionElseDeclaration<cr>
nnoremap <leader>t :YcmCompleter GetType<cr>
nnoremap <leader>p :YcmCompleter GetParent<cr>

" ======================================
" Virtualenv Support
" ======================================
"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    exec(compile(open(activate_this, "rb").read(), activate_this, 'exec'), dict(__file__=activate_this))
EOF

" ======================================
" Syntax Checking/Highlighting
" ======================================
let python_highlight_all=1
if has("syntax")
    syntax on
endif

" ======================================
" Color Schemes
" ======================================
"set background=dark
"colorscheme colorscheme
"let g:solarized_termcolors=256
"let g:solarized_contrast="high"
"let g:solarized_visibility="high"

" switch dark and light theme
"call togglebg#map("<F5>")

" ======================================
" File Browsing
" ======================================
let NERDTreeIgnore=['\.pyc$', '\~$']             " Ignore files in NERDTree
nnoremap <leader>nt  <esc>:NERDTree<cr>
nnoremap <leader>ntt <esc>:NERDTreeToggle<cr>

" ======================================
" Line Numbering
" ======================================
set number

" ======================================
" System Clipboard
" ======================================
set clipboard=unnamed                            " use OS clipboard

" ======================================
" vim-airline
" ======================================
let g:airline_theme = 'solarized'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1     " Enable the list of buffers
let g:airline#extensions#tabline#fnamemod = ':t' " Show just the filename
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1
set laststatus=2                                 " Always show statusline(with vim-airline)

" ======================================
" ctrlp
" ======================================
" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nnoremap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nnoremap <leader>bb :CtrlPBuffer<cr>
nnoremap <leader>bm :CtrlPMixed<cr>
nnoremap <leader>bs :CtrlPMRU<cr>

" ======================================
" Buffergator
" ======================================
" Use the right side of the screen
let g:buffergator_viewport_split_policy = 'R'
" I want my own keymappings...
let g:buffergator_suppress_keymaps = 1
" Looper buffers
"let g:buffergator_mru_cycle_loop = 1
" Go to the previous buffer open
nnoremap <leader>h  <esc>:BuffergatorMruCyclePrev<cr>
" Go to the next buffer open
nnoremap <leader>l  <esc>:BuffergatorMruCycleNext<cr>
" View the entire list of buffers open
nnoremap <leader>bl <esc>:BuffergatorOpen<cr>
" Shared bindings from Solution #1 from earlier
nnoremap <leader>T  <esc>:enew<cr>                     " Create new buffer
nnoremap <leader>bq <esc>:bp <BAR> bd #<cr>            " Close buffer

" ======================================
" Livedown
" ======================================
" should markdown preview get shown automatically upon opening markdown buffer
let g:livedown_autorun = 0
" should the browser window pop-up upon previewing
let g:livedown_open = 1
" the port on which Livedown server will run
let g:livedown_port = 1337
" the browser to use, can also be firefox, chrome or other, depending on your executable
let g:livedown_browser = ""
" launch the Livedown server and preview your markdown file
nnoremap <leader>mds <esc>:LivedownPreview<cr>
" stop the Livedown server
nnoremap <leader>mdk <esc>:LivedownKill<cr>
" launch/kill the Livedown server
nnoremap <leader>mdt <esc>:LivedownToggle<cr>
