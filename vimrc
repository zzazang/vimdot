" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
filetype plugin on

"{{ Environment {{
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
  set fileencodings=ucs-bom,utf-8,utf-16le,cp949,euc-kr,cp1252,iso-8859-15

  if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
          set termencoding=utf-8
  else
          set termencoding=cp949
  endif

"}}

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
Plugin 'Lokaltog/vim-easymotion'

" My Plugins here:
" Plugin 'taglist-plus'
Plugin 'DirDiff.vim'

Plugin 'scrooloose/nerdtree.git'
Plugin 'fugitive.vim'
Plugin 'Buffergator'
Plugin 'unimpaired.vim'
Plugin 'DeleteTrailingWhitespace'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Solarized'
Plugin 'L9'
Plugin 'FuzzyFinder'
Plugin 'bling/vim-airline'
Plugin 'justinmk/vim-sneak'
Plugin 'Markdown'
"
" ...
" call vundle#end()
"
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
set comments=sl:/*.mb:*.elx:*/
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

" Tap(Indent) Setting
set shiftwidth=2
set softtabstop=2
set tabstop=8
set expandtab
set smarttab
au BufNewFile,BufReadPost Makefile*,makefie*,*.mk set noet

"grep option
set grepprg=grep\ -nH\ --color\ $*

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>
nnoremap JJJJ <Nop>

" Cool tab-key completion stuff
set wildmenu
set wildmode=list:longest,full
set wildignore+=tags

" Backup related stuff------------
set backup    " keep a backup file
let bakDir = "~/.vim/bak"

if has("win32") || has("win64")
  let bakDir = $TMP."/vimbak"
elseif has("vms")
  set nobackup		" do not keep a backup file, use versions instead
endif

if !isdirectory(bakDir)
  call mkdir(bakDir, "p")
endif

let &backupdir=bakDir
" Backup related end------

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
if has("win32") || has("win64")
  let &guioptions = substitute(&guioptions, "t", "", "g")
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
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
    " Create dirs
    if !isdirectory(bakDir)
      call mkdir(myUndoDir, "p")
    endif

    let &undodir = myUndoDir
    set undofile
endif

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
      let colorstring = "ron#elflord#evening#koehler#murphy#pablo#desert#torte#"
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

color ron

"}}}

"{{{{Silver Searcher
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
"}}}}

"{{{plugin related etc
" Plugin configuration
let g:DeleteTrailingWhitespace_Action = 'delete'
let g:DeleteTrailingWhitespace = 1
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/]\.(git|hg|svn|pub|testing|util|Servers|.metadata|3rdPartySources|archive|experiment|intellij|pub|scripts|target)$',
  \ 'file': '\v\.(exe|so|dll|jar|jpg|pdf|sublime-project|sublime-workspace)$',
  \ }
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let NERDTreeHijackNetrw=1

"}}}

"{{{autocmd
" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

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
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

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

" color
map <C-v><F10> :execute RotateColorTheme()<CR>

" tab
map <C-n> <ESC>:tabnew<cr>

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

" A-] - Open the definition in a vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


inoremap {<CR> {<CR>}<C-o>O
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

"}}}
"{{{ taglist related
"-------------------------------------------------------------------
" taglist.vim : toggle the taglist window
" taglist.vim : define the title texts for make
" taglist.vim : define the title texts for qmake
"-------------------------------------------------------------------

noremap <silent> <F11>  <Esc><Esc>:Tlist<CR>
inoremap <silent> <F11>  <Esc><Esc>:Tlist<CR>

" Taglist setting
let tlist_make_settings  = 'make;m:makros;t:targets'
let tlist_qmake_settings = 'qmake;t:SystemVariables'
let Tlist_Process_File_Always = 0
let Tlist_Enable_Fold_Column = 0
let Tlist_Display_Tag_Scope = 0
"let Tlist_Sort_Type = "name"
let Tlist_Use_Right_Window = 1
let Tlist_Display_Prototype = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 0

if has("autocmd")
	" ----------  qmake : set file type for *.pro  ----------
	autocmd BufNewFile,BufRead *.pro  set filetype=qmake
endif " has("autocmd")

"let Tlist_Auto_Open = 1"}}}
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
nmap ,h :call Hv()<cr>

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

" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    if expl_win_num != -1
      let cur_win_nr = winnr()
      exec expl_win_num . 'wincmd w'
      close
      exec cur_win_nr . 'wincmd w'
      unlet t:expl_buf_num
    else
      unlet t:expl_buf_num
    endif
  else
    exec '1wincmd w'
    Vexplore
    let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

"}}}
"
"{{{Auto Commands
" Automatically cd into the directory that the file is in
"autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')
"autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /

" Remove any trailing whitespace that is in the file
" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif
"}}}

set viminfo='20,<500,"500,s50,h

au! BufWritePost .vimrc source %

