set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

"------------------
" Code Completions
"------------------
Plugin 'Shougo/neocomplcache'
Plugin 'mattn/emmet-vim'
Plugin 'Raimondi/delimitMate'
Plugin 'ervandew/supertab'
" snippets
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
"------ snipmate dependencies -------
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'

"-----------------
" Fast navigation
"-----------------
" Plugin 'edsono/vim-matchit' // cannot find
Plugin 'Lokaltog/vim-easymotion'

"--------------
" Fast editing
"--------------
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdcommenter'
Plugin 'sjl/gundo.vim'
Plugin 'godlygeek/tabular'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'yggdroot/indentline'

"--------------
" IDE features
"--------------
Plugin 'scrooloose/nerdtree'
"Plugin 'humiaozuzu/TabBar'
Plugin 'majutsushi/tagbar'
Plugin 'mileszs/ack.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-fugitive'
"Plugin 'Lokaltog/vim-powerline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'bronson/vim-trailing-whitespace'
if (executable("cscope"))
  Plugin 'cscope.vim'
endif
if (executable("ctags"))
  Plugin 'xolox/vim-misc'
  Plugin 'xolox/vim-easytags'
endif
Plugin 'terryma/vim-multiple-cursors'

"-------------
" Other Utils
"-------------
" Bundle 'humiaozuzu/fcitx-status'
"Plugin 'nvie/vim-togglemouse'
Plugin 'roxma/vim-paste-easy'
Plugin 'DrawIt'

"----------------------------------------
" Syntax/Indent for language enhancement
"----------------------------------------
Plugin 'Chiel92/vim-autoformat'
"------- web backend ---------
Plugin '2072/PHP-Indenting-for-VIm'
"Bundle 'tpope/vim-rails'
Plugin 'lepture/vim-jinja'
Plugin 'digitaltoad/vim-jade'

"------- web frontend ----------
Plugin 'othree/html5.vim'
" Bundle 'tpope/vim-haml'
Plugin 'pangloss/vim-javascript'
Plugin 'nono/jquery.vim'
Plugin 'groenewege/vim-less'
" Bundle 'wavded/vim-stylus'
Plugin 'nono/vim-handlebars'

"------- markup language -------
Plugin 'tpope/vim-markdown'
" Bundle 'timcharper/textile.vim'
Plugin 'stephpy/vim-yaml'

"------- Ruby --------
" Bundle 'tpope/vim-endwise'

"------- Go ----------
Plugin 'fatih/vim-go'

"------- FPs ------
Plugin 'kien/rainbow_parentheses.vim'
" Bundle 'wlangstroth/vim-racket'
" Bundle 'vim-scripts/VimClojure'
" Bundle 'rosstimson/scala-vim-support'

"------- Java / Kotlin -----
Plugin 'tfnico/vim-gradle'
Plugin 'udalov/kotlin-vim'

"------- Scala ------
Plugin 'derekwyatt/vim-scala'
Plugin 'derekwyatt/vim-sbt'
Plugin 'scalacommenter.vim'

"------ Swift -----
Plugin 'toyamarinyon/vim-swift'

"------ Rust -----
Plugin 'rust-lang/rust.vim'

"------ docker/k8s ----
Plugin 'ekalinin/dockerfile.vim'
Plugin 'towolf/vim-helm'

"------ Others ----
Plugin 'yoppi/fluentd.vim'

"--------------
" Color Schemes
"--------------
Plugin 'flazz/vim-colorschemes'
"Plugin 'rickharris/vim-blackboard'
"Plugin 'chriskempson/vim-tomorrow-theme'
"Plugin 'fisadev/fisa-vim-colorscheme'
"Plugin 'dracula/vim'

call vundle#end()
filetype plugin indent on     " required!

