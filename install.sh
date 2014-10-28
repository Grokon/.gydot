#!/usr/bin/env sh

GYPATH="$HOME/.gydot"

echo "# Backing up current configs"
today=`date +%Y%m%d`
for file in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc $HOME/.gitconfig $HOME/.gitignore-global ; do
    [ -e $file ] && mv -v $file $file.$today
done

echo "# Installing configs in $HOME directory"
if [ ! -d $GYPATH ]; then
	git clone https://github.com/Grokon/.gydot.git $GYPATH
else
	git pull
fi


# vim symlinks
ln -vs $GYPATH/.vim $HOME/.vim
ln -vs $GYPATH/.vim/vimrc $HOME/.vimrc

#git symlinks
ln -vs $GYPATH/.gitconfig $HOME/.gitconfig
ln -vs $GYPATH/.gitignore-global $HOME/.gitignore-global

#ln -vs $GYPATH/.vim/gvimrc $HOME/.gvimrc
#mkdir -p

echo "# Installing Vundle"
git clone https://github.com/gmarik/Vundle.vim.git $HOME/.vim/bundle/vundle

echo "# Installing Vim plugins using Vundle"
vim +PluginInstall +qall


echo "\n\n \033[0;32m....D O N E....!\033[0m"
