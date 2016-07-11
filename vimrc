set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Easymotion: for easy motion on speed
Plugin 'easymotion/vim-easymotion'
" Manipulate surrounding stuff ( ",',(,{,[ etc. )
Plugin 'tpope/vim-surround'
" Ruby extra support
Plugin 'vim-ruby/vim-ruby'
" Tagbar:
Plugin 'majutsushi/tagbar'
" Completion plugin of the week
Plugin 'Valloric/YouCompleteMe'
" RoR:
Plugin 'tpope/vim-rails'
" ctrlp
Plugin 'ctrlpvim/ctrlp.vim'
" FuzzyFinder:
Plugin 'vim-scripts/FuzzyFinder'
" GO:
Plugin 'fatih/vim-go'
" vim-misc for easytags
Plugin 'xolox/vim-misc'
" Easytags:
Plugin 'xolox/vim-easytags'
" Abolish:
Plugin 'tpope/vim-abolish'
" Endwise:
"Plugin 'tpope/vim-endwise' " destroys tabs?
" Snippets Plugin: ( + dependencies )
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
" Optional:
Plugin 'honza/vim-snippets'
" Ansible:
Plugin 'pearofducks/ansible-vim'
" Airline:
Plugin 'vim-airline/vim-airline'
" Tern
Plugin 'ternjs/tern_for_vim'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just
" :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
"
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
    syntax on
endif

colorscheme default
set background=dark           "  Backgound is dark or light
set backspace=2               "  Allow backspacing over identatiom, end-of-line, and start-of-line
set hidden                    "  Enable working with hidden buffers
set vb                        " no beep
set ic                        " ingnore case in search
set scs                       " case sensitive when upper case search pattern
set incsearch                 " while typing search for pattern
set scroll=0                  " set Pg Up/Dn to half screen size
set ru                        " cursor position
set cpt=.,w,b,u,t,i           " completion by all buffers, included files, etc
set bs=eol,start,indent       " allow backspacing over autoindent, line breaks, start of insert
set laststatus=2              " Always show status line
set wildmenu                  " Option menu on the lower bar above the command line for vim options
set nowrap                    " no wraping of long lines
set pastetoggle=<F2>          " For pasting text without indentation
set mouse=a                   " For windows resizing
if &term =~ '^screen'         " Tmux ttymouse mode
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

syntax on                     " Enable syntax highlighting
filetype on                   " Enable filetype detection
filetype indent on            " Enable filetype-specific indenting
filetype plugin on            " Enable filetype-specific plugins

" Ctrl-j to take current line one line lower
nmap <C-j> O<Esc>j            

"-----------------------------
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.
" Type z/ to toggle highlighting on/off.
nnoremap z/ :if AutoHighlightToggle()<Bar>set hls<Bar>endif<CR>
function! AutoHighlightToggle()
  let @/ = ''
  if exists('#auto_highlight')
    au! auto_highlight
    augroup! auto_highlight
    setl updatetime=4000
    echo 'Highlight current word: off'
    return 0
  else
    augroup auto_highlight
      au!
      au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=500
    echo 'Highlight current word: ON'
    return 1
  endif
endfunction
"------------------------------

"Indentation
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set autoindent
set list
set listchars=tab:✗\ ,trail:✗,extends:»,precedes:« " Unprintable chars mapping
:autocmd FileType javascript,css,html,python,cython,vala,lua setlocal expandtab
:autocmd FileType javascript,css,html,python,cython,vala,lua setlocal shiftwidth=4
:autocmd FileType javascript,css,html,python,cython,vala,lua setlocal softtabstop=4
:autocmd FileType * setlocal autoindent
:autocmd FileType vala setlocal cindent
:autocmd FileType ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
filetype plugin indent on

"" wildignore
""python
:set wildignore+=*.pyc,*.pyo
"c/cpp
:set wildignore+=*.o,*.obj
""editors
:set wildignore+=*.swp,*~
"java
:set wildignore+=*.class
""VCS
:set wildignore+=*/.git/*,*/.hg/*,*/.svn/*

" Tagbar
nmap <F8> :TagbarToggle<CR>
" auto focus on tagbar when it opens
let g:tagbar_autofocus = 1
let g:tagbar_type_css = {
            \ 'ctagstype' : 'Css',
    \ 'kinds'     : [
        \ 'c:classes',
        \ 's:selectors',
        \ 'i:identities'
    \ ]
    \ }

" Ruby auto complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" FuzzyFinder to find files TODO: make folders be deleted immidiatly
nmap <F3> :FufFileWithCurrentBufferDir<CR> 

" easytags
:set tags=./tags,.tags;
:let g:easytags_dynamic_files = 1

" ctrlp:
let g:ctrlp_max_files=0

" SnipMate:
:imap <C-J> <Plug>snipMateNextOrTrigger

" YouCompleteMe:
let g:ycm_autoclose_preview_window_after_completion = 1

"" I am a puts debugger!!!
" puts the caller
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>
