#!/usr/bin/env sh

GYPATH="$HOME/.gydot"

echo "# Backing up current configs"
today=`date +%Y%m%d`
for file in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc ; do
    [ -e $file ] && mv -v $file $file.$today
done

echo "# Installing configs in $HOME directory"
if [ ! -d $GYPATH ]; then
	git clone https://github.com/Grokon/.gydot.git $GYPATH
else
	git pull
fi


ln -vs $GYPATH/.vim $HOME/.vim
ln -vs $GYPATH/.vim/vimrc $HOME/.vimrc
#ln -vs $GYPATH/.vim/gvimrc $HOME/.gvimrc
#mkdir -p

echo "# Installing Vundle"
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/vundle

echo "# Installing Vim plugins using Vundle"
vim +PluginInstall +qall


echo "\n\n \033[0;32m....D O N E....!\033[0m"
