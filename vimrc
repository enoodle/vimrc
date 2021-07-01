set nocompatible              " be iMproved, required

" Vim-Plug installation insurance:
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

" vim-virtualenv
Plug 'plytophogy/vim-virtualenv'
" plugin on GitHub repo
Plug 'tpope/vim-fugitive'
" gitgutter
Plug 'airblade/vim-gitgutter'
" plugin from http://vim-scripts.org/vim/scripts.html
Plug 'vim-scripts/L9'
" Easymotion: for easy motion on speed
Plug 'easymotion/vim-easymotion'
" Manipulate surrounding stuff ( ",',(,{,[ etc. )
Plug 'tpope/vim-surround'
" Ruby extra support
Plug 'vim-ruby/vim-ruby'
" Tagbar:
Plug 'majutsushi/tagbar'
" Completion plugin of the week
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': ':CocInstall coc-yaml coc-go coc-json coc-tsserver coc-pyright coc-sh coc-vetur'}
" RoR:
Plug 'tpope/vim-rails'
" FuzzyFinder:
Plug 'vim-scripts/FuzzyFinder'
" Fzf:
Plug 'junegunn/fzf', { 'do': './install --all'}
Plug 'junegunn/fzf.vim'
" GO:
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
"" vim-misc for easytags
"Plugin 'xolox/vim-misc'
"" Easytags:
"Plugin 'xolox/vim-easytags'
" Abolish:
Plug 'tpope/vim-abolish'
" Endwise:
"Plugin 'tpope/vim-endwise' " destroys tabs?
" Snippets Plugin: ( + dependencies )
" Plug 'MarcWeber/vim-addon-mw-utils'
" Plug 'tomtom/tlib_vim'
" Plug 'garbas/vim-snipmate'
Plug 'SirVer/ultisnips'
" Optional:
Plug 'honza/vim-snippets'
" Ansible:
Plug 'pearofducks/ansible-vim'
" Airline:
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Tern
" Plug 'ternjs/tern_for_vim'
" Indent Guid:
Plug 'nathanaelkane/vim-indent-guides'
" SemanticHighlight:
Plug 'jaxbot/semantic-highlight.vim'
" Bufexplorer:
Plug 'jlanzarotta/bufexplorer'
" Colorschemes:
Plug 'flazz/vim-colorschemes'
" IndentWise
Plug 'jeetsukumaran/vim-indentwise'
" javascript support
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
" Ack: (ag)
Plug 'mileszs/ack.vim'
" illuminate
Plug 'RRethy/vim-illuminate'
" vim-commentary
Plug 'tpope/vim-commentary'
" jsdoc
Plug 'heavenshell/vim-jsdoc'
" polyglot
Plug 'sheerun/vim-polyglot'
" vimux
Plug 'preservim/vimux'
" vim-delve
Plug 'sebdah/vim-delve'

call plug#end()

" have syntax highlighting in terminals which can display colours:
if has('syntax') && (&t_Co > 2)
    syntax on
endif

set t_Co=256
colorscheme default
set background=dark           "  Backgound is dark or light
set backspace=2               "  Allow backspacing over identatiom, end-of-line, and start-of-line
set hidden                    "  Enable working with hidden buffers
set vb                        " no beep
set ic                        " ingnore case in search
set scs                       " case sensitive when upper case search pattern
set incsearch                 " while typing search for pattern
set scroll=0                  " set Pg Up/Dn to half screen size
set so=0                      " set scrolloffset to 0 'scrolloff'
set sidescrolloff=10          " set horizontal scroll offset
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
nnoremap <M-j> :m+<CR>
nnoremap <M-k> :m .-2<CR>

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
:autocmd FileType javascript.jsx,javascript,css,html,ruby,yaml,vue setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
:autocmd FileType python,cython,vala,lua setlocal expandtab sts=4 sw=4 ts=4
:autocmd FileType * setlocal autoindent
:autocmd FileType vala setlocal cindent
:autocmd FileType python let python_highlight_all=1
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

" Open files from last used position
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

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
" autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
" Ruby use old RE generator which is much better
" details: http://stackoverflow.com/questions/16902317/vim-slow-with-ruby-syntax-highlighting
:autocmd FileType ruby setlocal re=1

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" FuzzyFinder to find files in current directory
nmap <F3> :FufFileWithCurrentBufferDir<CR>

" easytags
:set tags=./tags,.tags;
":let g:easytags_dynamic_files = 1

" " SnipMate:
" :imap && <esc>a<Plug>snipMateNextOrTrigger
" let g:snipMate = { 'snippet_version' : 1 }
" UltiSnips:
let g:UltiSnipsExpandTrigger="*&"

" YouCompleteMe:
let g:ycm_autoclose_preview_window_after_completion = 1

"" I am a puts debugger!!!
" puts the caller
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

" Start with indent guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 30


" Airline:
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='cool'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '»'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '«'
let g:airline_symbols.branch = '⎇'


" SyntaxHighligh:
"let g:semanticTermColors = [28,1,2,3,4,5,6,7,25,9,10,34,12,13,14,15,16,125,124,19]
"let g:semanticTermColors = [1,2,3,5,6,7,10,11,12,13,]
"let g:semanticTermColors = [28,1,2,3,5,6,7,9,10,34,13,14,15,125,124,57,153,39]
let g:semanticTermColors = [1,2,3,4,5,6,7,9,10,12,14,15,34,125,124,153,109,]
:nnoremap <leader>hs :SemanticHighlightToggle<CR>


let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax
let g:yml_syntax_folding=1
au FileType yml setlocal foldmethod=syntax

" Fzf:
" ctrlp replacement
nmap <C-p> :FZF<CR>
nmap ; :Buffers<CR>
nmap <Leader>t :Tags<CR>
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'LineNr'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let $FZF_DEFAULT_COMMAND = 'ag -g ""'


" Ack: (ag)
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
nmap <C-k> :Ack! "\b<cword>\b"<CR>

" Spell check git commit messages
autocmd FileType gitcommit setlocal spell

" vim-virtualenv
" NOTICE: pylint, pyflake has to come from the venv as well
let g:virtualenv_auto_activate = 1

" vim-illuminate
hi link illuminatedWord Visual
map zt :IlluminationToggle<CR>

" gitgutter colors
highlight GitGutterAdd    guifg=#009900 guibg=#073642 ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#bbbb00 guibg=#073642 ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#ff2222 guibg=#073642 ctermfg=1 ctermbg=0

" Coc configuration:
source $HOME/vimrc/coc_conf.vim
