#!/bin/sh

CWD=$(dirname $0)

git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
rm -f ~/.vimrc && ln -s $CWD/vimrc ~/.vimrc
rm -f ~/.gvimrc && ln -s $CWD/gimrc ~/.gvimrc

vim +PluginInstall +qall

