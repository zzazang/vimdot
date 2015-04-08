" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

"{{{ Environment
  " Identify platform {{
      silent function! OSX()
          return has('macunix')
      endfunction
      silent function! LINUX()
          return has('unix') && !has('macunix') && !has('win32unix')
      endfunction
      silent function! WINDOWS()
          return  (has('win16') || has('win32') || has('win64'))
      endfunction
  " }}

  " Basics {{
      set nocompatible        " Must be first line
      " On Windows, also use '.vim' instead of 'vimfiles';
      " this makes synchronization across (heterogeneous) systems easier.
      if WINDOWS()
        language messages en_US.ISO_8859-1
        set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
      else
        set shell=/bin/sh
      endif
  " }}

  " Neovim Initialization {{
      if has('neovim')
          let s:python_host_init = 'python2 -c "import neovim; neovim.start_host()"'
          let &initpython = s:python_host_init
          let &initclipboard = s:python_host_init
          set unnamedclip
      endif
  " }}
  set encoding=utf-8
  setglobal fileencoding=utf-8
  " Newer Windows files might contain utf-8 or utf-16 LE so we might
  " want to try them first.
  set fileencodings=ucs-bom,utf-8,cp949,euc-kr,cp1252,iso-8859-15

  if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
          set termencoding=utf-8
  else
          set termencoding=cp949
  endif

"}}}

"{{{ vim bundle
"--------------------------------------------------------------------
"vim bundle
"--------------------------------------------------------------------

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
"
" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" original repos on github
Plugin 'tpope/vim-fugitive'
"Plugin 'Lokaltog/vim-easymotion'

" My Plugins here:
Plugin 'tagbar'
Plugin 'DirDiff.vim'

Plugin 'ctrlp.vim'

"Plugin 'fugitive.vim'
Plugin 'Buffergator'

" pair of bracket
Plugin 'unimpaired.vim'

Plugin 'DeleteTrailingWhitespace'

"sublime like multiline edit
Plugin 'terryma/vim-multiple-cursors'

Plugin 'Solarized'
Plugin 'L9'
Plugin 'FuzzyFinder'

"Statusbar
Plugin 'bling/vim-airline'

"motion
Plugin 'justinmk/vim-sneak'

"Aligning Text
Plugin 'godlygeek/tabular'

Plugin 'plasticboy/vim-markdown'
if (executable("cscope"))
  Plugin 'cscope.vim'
endif
Plugin 'scrooloose/nerdtree.git'
"Plugin 'The-NERD-Commenter'
if (executable("ctags"))
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-easytags'
endif

call vundle#end()

filetype plugin indent on     " required!

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"}}}

"{{{ settings
" allow backspacing over everything in insert mode
"set backspace=indent,eol,start
set backspace=2

set history=100		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set number
set visualbell        " vb : 키를 잘못 눌렀을 때 삑 소리 대신 화면이 번쩍임"
set cmdheight=2
set noequalalways
"set comments=sl:/*.mb:*.elx:*/
set scrolloff=3
set autoindent
set showmode

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" Incremental searching is sexy
set incsearch
set hlsearch
set showmatch

set nowrap
set listchars=extends:>,precedes:<

" Tab(Indent) Setting
set shiftwidth=2
set softtabstop=2
set tabstop=8
set expandtab
set smarttab
au BufNewFile,BufReadPost Makefile*,makefie*,*.mk set noet

set fileformat=unix
set fileformats=unix,dos
"set nobinary

"grep option
set grepprg=grep\ -nH\ --color\ $*

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Cool tab-key completion stuff
set wildmenu
set wildmode=list:longest,full
set wildignore+=tags

set laststatus=2
set foldenable
set foldmethod=marker

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
if has("win32") || has("win64")
  let &guioptions = substitute(&guioptions, "t", "", "g")
endif

set colorcolumn=80

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

"doxygen syntax highlight
let g:load_doxygen_syntax=1

" Set off the other paren
highlight MatchParen ctermbg=4

set autowrite     " Automatically :write before running commands

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Don't use Ex mode, use Q for formatting
map Q gq

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
  let myUndoDir = expand(vimDir . '/persistent-undo')

  if has("win32") || has("win64")
    let myUndoDir = $TMP."/vim/persistent_undo"
  endif

  " Create dirs
  if !isdirectory(myUndoDir)
    call mkdir(myUndoDir, "p")
  endif

  let &undodir = myUndoDir
  set undofile
endif

" Backup related stuff------------
set backup    " keep a backup file
let bakDir = expand(vimDir . '/bak')

if has("win32") || has("win64")
  let bakDir = $TMP."/vim/bak"
elseif has("vms")
  set nobackup		" do not keep a backup file, use versions instead
endif

if !isdirectory(bakDir)
  call mkdir(bakDir, "p")
endif

let &backupdir=bakDir
" Backup related end------

" swapfile stuff------------
set swapfile

let swapDir = expand(vimDir . '/swp')

if has("win32") || has("win64")
  let swapDir = $TMP."/vim/swp"
endif

if !isdirectory(swapDir)
  call mkdir(swapDir, "p")
endif

let &directory=swapDir
" swapfile end  ------------
" }}}

"{{{Tab Completion
" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>
"}}}

"{{{Theme Rotating
let themeindex=0
function! RotateColorTheme()
   let y = -1
   while y == -1
      let colorstring = "ron#elflord#evening#koehler#murphy#pablo#desert#torte#solarized#"
      let x = match( colorstring, "#", g:themeindex )
      let y = match( colorstring, "#", x + 1 )
      let g:themeindex = x + 1
      if y == -1
         let g:themeindex = 0
      else
         let themestring = strpart(colorstring, x + 1, y - x - 1)
         return ":colorscheme ".themestring
      endif
   endwhile
endfunction
" color
map <C-v><F10> :execute RotateColorTheme()<CR>

"}}}

"{{{Silver Searcher
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
"}}}

"{{{autocmd
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
"}}}

"{{{ MAP key
"-----------------------------------------------------
" map functions keys
"-----------------------------------------------------
set pastetoggle=<leader>p

"<F11> is set to Tlist below
nnoremap <F12> :call ToggleMouse()<CR>
function! ToggleMouse()
  if &mouse == 'a'
    set mouse=
    echo "Mouse usage disabled"
  else
    set mouse=a
    echo "Mouse usage enabled"
  endif
endfunction

" Edit vimrc \ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.vimrc<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj
inoremap <silent> <Up> <Esc>gka
inoremap <silent> <Down> <Esc>gja

" Good call Benjie (r for i)
nnoremap <silent> <Home> i <Esc>r
nnoremap <silent> <End> a <Esc>r

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Alt-] - Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


inoremap {<CR> {<CR>}<C-o>O
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"}}}

"{{{ tagbar related
nmap <F8> :TagbarToggle<CR>
""}}}

"{{{ cscope & tags related
"--------------------------------------------------------------------
"cscope & tags
"--------------------------------------------------------------------
set tags=tags;/

function! LoadCscope()
  if (executable("cscope") && has("cscope"))
    let UpperPath = findfile("cscope.out", ".;")
    if (!empty(UpperPath))
      let path = strpart(UpperPath, 0, match(UpperPath, "cscope.out$") - 1)
      if (!empty(path))
        let s:CurrentDir = getcwd()
        let direct = strpart(s:CurrentDir, 0, 2)
        let s:FullPath = direct . path
        let s:AFullPath = globpath(s:FullPath, "cscope.out")
        let s:CscopeAddString = "cs add " . s:AFullPath . " " . s:FullPath
        execute s:CscopeAddString
      endif
    endif
  endif
endfunction
command! LoadCscope call LoadCscope()

" cscope keymap
nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>

" s: Find this C symbol
nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>

"}}}

"{{{ Useful
let g:netrw_browse_split = 0
let g:netrw_altv = 1

"============ open CWD =============
nmap ,od :e ./<cr>

"============ project specific settings =============
if filereadable(".project.vimrc")
source .project.vimrc
endif

"{{{ Open URL in browser

if WINDOWS()
  let $PATH = $PATH . ';c:\Program Files (x86)\Mozilla FireFox' . ';c:\Program Files\Mozilla FireFox'
endif

function! Browser ()
   let line = getline (".")
   let line = matchstr (line, "http[^   ]*")

   exec "!firefox ".line
endfunction

"}}}
"============ file buffer CleanClose =============
func! CleanClose(tosave)
if (a:tosave == 1)
w!
endif
let todelbufNr = bufnr("%")
let newbufNr = bufnr("#")
if ((newbufNr != -1) && (newbufNr != todelbufNr) && buflisted(newbufNr))
exe "b".newbufNr
else
bnext
endif

if (bufnr("%") == todelbufNr)
new
endif
exe "bd".todelbufNr
endfunc

nmap ,cf :call CleanClose(0)<cr>

"============ hexViewer setting =============
let b:hexViewer = 0
func! Hv()
        if (b:hexViewer == 0)
                let b:hexViewer = 1
                exe "%!xxd"
        else
                let b:hexViewer = 0
                exe "%!xxd -r"
        endif
endfunc
nmap <leader>h :call Hv()<cr>

"============ man page setting =============
func! Man()
let sm = expand("<cword>")
exe "!man -S 2:3:4:5:6:7:8:9:tcl:n:l:p:o ".sm
endfunc
nmap ,ma :call Man()<cr><cr>

"============ make setting =============
let startdir = getcwd()
func! Make()
exe "!cd ".startdir
exe "make"
endfunc
nmap ,mk :call Make()<cr><cr>

""" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

"grep related
nmap _g :grep <C-R>=expand("<cword>")<CR><CR>

map <F2> :cprev<CR>
map <F3> :cnext<CR>
map <F4> :botright cwindow<CR>

map <leader>w :call Browser()<CR>
"}}}

"{{{Auto Commands
" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
"autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
autocmd BufRead,BufWrite,BufNewFile,BufEnter *.md set filetype=markdown
" Open markdown files with Chrome.
autocmd BufRead,BufNewFile,BufEnter *.md  exe 'noremap <F7> :!start firefox %:p<CR>'

" Remove any trailing whitespace that is in the file
" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

"Auto apply .vimrc
autocmd! BufWritePost .vimrc source %
"}}}

"{{{ Plugins
  " Fuzzy Finder {
  let g:FuzzyFinderOptions = { 'Base':{}, 'Buffer':{}, 'File':{}, 'Dir':{}, 'MruFile':{}, 'MruCmd':{}, 'FavFile':{}, 'Tag':{}, 'TaggedFile':{}}
  " 특정 파일 제외
  let g:FuzzyFinderOptions.File.excluded_path = '\v\~$|\.o$|\.exe$|\.bak$|\.swp$|\.class$|\.settings$|CVS|((^|[/\\])\.[/\\]$)'
  " 대소문자 구분하기 (0 : 대소문자 구분, 1 : 대소문자 구분 안함)
  let g:FuzzyFinderOptions.Base.ignore_case = 0

  " 현재 디렉토리 이하에서 파일명으로 검색해서 읽어오기
  map <Leader>ff <ESC>:FufFile **/<CR>

  " 버퍼 목록에서 검색해서 이동하기
  map <Leader>fb <ESC>:FufBuffer<CR>

  " 디렉토리에서 검색해서 이동하기
  map <Leader>fd <ESC>:FufDir!<CR>
  " }

  " EasyTags {
  " Disabling for now. It doesn't work well on large tag files
  let g:loaded_easytags = 1  " Disable until it's working better
  let g:easytags_cmd = 'ctags'
  let g:easytags_dynamic_files = 1
  if !has('win32') && !has('win64')
    let g:easytags_resolve_links = 1
  endif
  " }

  " NerdTree {
  map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
  map <leader>e :NERDTreeFind<CR>
  nmap <leader>nt :NERDTreeFind<CR>

  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\\.pyc', '\\\~$', '\\.swo$', '\\.swp$', '\\.git', '\\.hg', '\\.svn', '\\.bzr']
  let NERDTreeChDirMode=0
  let NERDTreeQuitOnOpen=1
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1
  " }

  " DeleteTrailingWhiteSpace {
  let g:DeleteTrailingWhitespace_Action = 'delete'
  let g:DeleteTrailingWhitespace = 1
  " }

  " ctrlp {
  let g:ctrlp_custom_ignore = {
        \ 'dir': '\v[\/]\.(git|hg|svn|pub|testing|util|Servers|.metadata|3rdPartySources|archive|experiment|intellij|pub|scripts|target)$',
        \ 'file': '\v\.(exe|so|dll|jar|jpg|pdf|sublime-project|sublime-workspace)$',
        \ }
  let g:ctrlp_max_files = 0
  let g:ctrlp_max_depth = 40
  " }

  " Tabularize {
  if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\\zs<CR>
    vmap <Leader>a:: :Tabularize /:\\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a| :Tabularize /|<CR>
    vmap <Leader>a| :Tabularize /|<CR>
  endif
  " }

  " Solarized
  syntax enable
  set background=dark
  colorscheme solarized
  if has('gui_running')
    set background=light
  else
    set background=dark
  endif

"}}} Plugins

set viminfo='20,<500,"500,s50,h


