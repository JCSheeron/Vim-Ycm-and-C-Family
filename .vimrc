" ---------------------- USABILITY CONFIGURATION ----------------------
"  Basic and pretty much needed settings to provide a solid base for
"  source code editting

" don't make vim compatible with vi, otherwise it conflicts with Vundle and
" other plugins
set nocompatible

" **** General behavior -- things most likely to be edited early in the file

" Change the leader key
" Do this first/early so references below use the new leader
let mapleader = ","

" set how many lines to read variables from
set modelines=0

" setup backup and swap related settings
set backup
set swapfile
set backupext=.bak
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swap//
" make the first backup special
set patchmode=.orig

" turn on syntax highlighting
let python_highlight_all=1
syntax on

" show line numbers
set number

" show file stats
set ruler

" status bar
set laststatus=2 

" last line
" showmode i snot needed with lightline
"set showmode
set noshowmode
set showcmd

" help quick screen redraw
set ttyfast

" screen will not be redrawn while running macros, registers or other
" non-typed comments
set lazyredraw

" enable mouse support for scrolling
set mouse=a

" make a mark for column 80, but wrap after 79 columnns
set colorcolumn=80
set textwidth=79
" set wrap on by default
set wrap
" turn off wrapping for python files
au BufRead,BufNewFile *py,*pyw,*.txt set nowrap

" by default, in insert mode backspace won't delete over line breaks, or 
" automatically-inserted indentation, let's change that
set backspace=indent,eol,start

" Blink cursor on error instead of beeping (grrr)
" set visualbell

" reload files changed outside vim
set autoread         

" allow hidden buffers -- dont't unload buffers when they are abandoned
" instead stay in the background
set hidden

" keep the cursor visible within 3 lines when scrolling
set scrolloff=3

" turn on spell check for text files
"au BufRead,BufNewFile *.txt set spell
" turn on spell check
set spell

" underline the line the cursor is on
" Cursor highlight taken care of by color scheme
set cursorline

" **** Key mapping
" remap the escape key to something easier to reach
" there will be a slight pause after the first 'j' waiting for the next one
" but this is visual, and should not cause a typing issue
" Go to normal (command) mode and eat up the moving back of the cursor.
imap jj <Esc>l
" Eat up the moving back of the cursor when going to normal (command) mode.
" This is commented out, because it causes letters to be printed when the arrow
" keys are pressed.
"imap <Esc> <Esc>l

" map <leader>O in normal modde to insert a line above without staying in insert mode
" map <leader>o in normal mode to insert a line below without staying in insert mode
nmap <leader>O O<Esc>
nmap <leader>o o<Esc>

" Make navigation for split windows easier
" Use the normal navigation keys and Ctrl
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" **** Formatting
" Indentation
set expandtab       " use spaces instead of tabs
set autoindent      " autoindent based on line above, works most of the time
set smartindent     " smarter indent for C-like languages
" default to 4 tabs.  File specific settings below
set shiftwidth=4    " when reading, tabs are 4 spaces
set softtabstop=4   " in insert mode, tabs are 4 spaces
set tabstop=4

" For the amount of space used for a new tab use shiftwidth.
" Python and text files use 4 spaces for tabs
" c/cpp use 2 spaces for tabs
au BufRead,BufNewFile *py,*pyw,*.txt set tabstop=4
au BufRead,BufNewFile *py,*pyw,*.txt set shiftwidth=4
au BufRead,BufNewFile *py,*pyw,*.txt set softtabstop=4

au BufRead,BufNewFile *.c,*.cpp,*.h set tabstop=2
au BufRead,BufNewFile *.c,*.cpp,*.h set shiftwidth=2
au BufRead,BufNewFile *.c,*.cpp,*.h set softtabstop=2

au BufRead,BufNewFile Makefile* set noexpandtab

" Use the below highlight group when displaying bad whitespace is desired.
highlight BadWhitespace ctermbg=red guibg=red

" Display tabs at the beginning of a line in Python mode as bad.
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/
" Make trailing whitespace be flagged as bad.
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.cpp match BadWhitespace /\s\+$/

" Searching
"nnoremap / /\v
"vnoremap / /\v
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
"map <leader><space> :let @/=''<cr> " clear search

" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
" nnoremap <space> za

" **** File format related
" encoding is utf 8
set encoding=utf-8
set fileencoding=utf-8

" set unix line endings
set fileformat=unix
" when reading files try unix line endings then dos, also use unix for new
" buffers
set fileformats=unix,dos

" **** Color scheme (terminal)
set t_Co=256
set background=dark
let g:solarized_termcolors=256
let g:solarized_termtrans=1
" put https://raw.github.com/altercation/vim-colors-solarized/master/colors/solarized.vim
" in ~/.vim/colors/ and uncomment:
colorscheme solarized

" set the color theme to wombat256
"colorscheme wombat256
" and set the mark color to DarkSlateGray
"highlight ColorColumn ctermbg=lightgray guibg=lightgray

" **** Other settings

" enable matchit plugin which ships with vim and greatly enhances '%'
runtime macros/matchit.vim

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" suggestion for normal mode commands
set wildmode=list:longest

" ---------------------- PLUGIN CONFIGURATION ----------------------
" Vundle and perhaps other plugins have trouble when filetype is on
" Turn off for now -- turn back on after plugins
filetype off
filetype plugin indent off

" initiate Vundle
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"****  start plugin defintion
" Foldin help
Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

" syntax checking
Plugin 'scrooloose/syntastic'
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    " when to auto check
    let g:syntastic_check_on_open = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_check_on_w = 1
    " use flake8 as the python checker
    let g:syntastic_python_flake8_exec = '/usr/bin/python3'

    " PEP8 Python checking
Plugin 'nvie/vim-flake8'

" auto complete
Plugin 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_global_ycm_extra_conf = '.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_python_binary_path = '/usr/bin/python3'
" as you type popup and sematic trigger (i.e. popup after typeing . or -> in
" c++) popup. If off, you can force it with <C-Space>
let g:ycm_auto_trigger = 1
" to turn off just the identifier completer but keep the sematic tirggers
" set the min number of chars for completion to a large number
let g:ycm_min_num_of_chars_for_completion = 3
" config handling of .ycm_extra_config.py files for c family
" compilation/completion
" Config a global version if wanted
"let g:ycm_global_ycm_extra_conf = '.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
" Set to 1 if you want annoying confirmation of ycm file usagg
let g:ycm_confirm_extra_conf=1

" let VIM and YouCompleteMe aware of python virtualenv
"python3 << EOF
"import os
"import sys
"if 'VIRTUAL_ENV' in os.environ:
"    project_base_dir = os.environ['VIRTUAL_ENV']
"    print(project_base_dir)
"    activate_this = os.path.join(project_base_dir, '/bin/activate')
"    print(activate_this)
"    exec(open(activate_this).read())
"EOF

" nerdtree file tree
Plugin 'scrooloose/nerdtree'
" how to ignore files in NERDTree
" let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" NERD Commenter
Plugin 'scrooloose/nerdcommenter'

"Plugin 'vim-scripts/L9'
"Plugin 'vim-scripts/FuzzyFinder'

" configurable status line
Plugin 'itchyny/lightline.vim'      
    let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
    \ 'left': [ ['mode', 'paste'],
    \         ['readonly', 'filename', 'modified', 'spell', 'syntastic'] ],
    \ 'right': [ [ 'lineinfo' ], ['percent'], 
    \          [ 'fileformat', 'fileencoding', 'filetype' ] ] 
    \ },
    \ 'component': {
    \ 'filename': '%F',
    \ 'spell': '%{&spell?&spelllang:"no spell"}',
    \ 'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}'
    \ },
    \ 'component_visible_condition': {
    \   'readonly': '(&filetype!="help"&& &readonly)',
    \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
    \ },
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '|', 'right': '|' },
    \ 'component_expand': { 'syntastic': 'SyntasticStatuslineFlag' },
    \ 'component_type': { 'syntastic': 'error' }
    \}

Plugin 'kshenoy/vim-signature'
"Plugin 'Lokaltog/vim-easymotion'    
"Plugin 'tpope/vim-surround'         
" -- Web Development
"Plugin 'Shutnik/jshint2.vim'        
"Plugin 'mattn/emmet-vim'            
"Plugin 'kchmck/vim-coffee-script'   
"Plugin 'groenewege/vim-less'        
"Plugin 'skammer/vim-css-color'      
"Plugin 'hail2u/vim-css3-syntax'     
"Plugin 'digitaltoad/vim-jade'       

" end plugin definition
call vundle#end()            " required for vundle

" filetype off for plugins to load correctly -- turn it on now
filetype plugin indent on

" Format options
" Set formating options after filetype plugin runs to prevent
" them from being overwritten by ftplugin
"set formatoptions=tcqrn1
"tcq is default
set formatoptions=tcqr

" Turn off settings in 'formatoptions' relating to comment formatting.
" - c : do not automatically insert the comment leader when wrapping based on
"    'textwidth'
" - o : do not insert the comment leader when using 'o' or 'O' from command mode
" - r : do not insert the comment leader when hitting <Enter> in insert mode
" Python: not needed
" C: prevents insertion of '*' at the beginning of every line in a comment
"au BufRead,BufNewFile *.c,*.cu,*.cpp,*.h set formatoptions-=c formatoptions-=o formatoptions-=r filetype=cpp
setlocal formatoptions-=o
au BufRead,BufNewFile *.c,*.cu,*.cpp,*.h setlocal formatoptions-=o
au FileType vim setlocal formatoptions-=o

" start NERDTree on start-up and focus active window
"autocmd VimEnter * NERDTree
"autocmd VimEnter * wincmd p

" map FuzzyFinder
"noremap <leader>b :FufBuffer<cr>
"noremap <leader>f :FufFile<cr>

" use zencoding with <C-E>
"let g:user_emmet_leader_key = '<c-e>'

" run JSHint when a file with .js extension is saved
" this requires the jsHint2 plugin
"autocmd BufWritePost *.js silent :JSHint


