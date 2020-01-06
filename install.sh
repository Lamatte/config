#!/bin/sh

function install_resource() {
  if [ -L ~/$1 ]; then
    echo Link to $1 already exists
  else
    echo "Installing resource $1"
    if [ -e ~/$1 ]; then
      echo "Backuping resource ~/$1 to ~/$1.backup"
      mv ~/$1 ~/$1.backup
    fi
    ln -s $1 ~
  fi
}

echo "Installing packages..."
sudo pacman -S --needed vim picom slock xmonad feh xautolock dmenu

echo "Installing Vundle.vim..."
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "Vundle.vim is already installed, consider pulling changes"
fi

echo "Installing resource files..."
for resource in .vimrc .xmonad .xmobarrc .zshrc .Xresources; do
  install_resource $resource
done

echo "Installing vim plugins..."
vim +PluginInstall +qall


