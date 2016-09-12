#!/bin/sh

CWD=$(dirname $0)

#rm -rf $CWD/bundle

git clone https://github.com/gmarik/Vundle.vim.git $CWD/bundle/Vundle.vim
vim +PluginInstall +qall

