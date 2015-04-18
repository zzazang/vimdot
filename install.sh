#!/bin/sh

CWD=$(pwd)

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
rm -f ~/.vimrc && ln -s $CWD/vimrc ~/.vimrc
rm -f ~/.gvimrc && ln -s $CWD/gvimrc ~/.gvimrc

vim +PluginInstall +qall

