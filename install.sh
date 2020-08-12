#!/bin/bash

function header()  {
  echo -e "\e[32m\e[1m$*\e[0m"
}

function install_yay() {
  header "Installing yay..."
  cd /opt
  sudo git clone https://aur.archlinux.org/yay-git.git
  sudo chown -R emcu7421:wheel ./yay-git
  cd yay-git
  makepkg -si
}

function install_resource() {
  if [ -L ~/$1 ]; then
    echo Link to $1 already exists
  else
    echo "Installing resource $1"
    if [ -e ~/$1 ]; then
      echo "Backuping resource ~/$1 to ~/$1.backup"
      mv ~/$1 ~/$1.backup
    fi
    ln -s $DIR/$1 ~
  fi
}

export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo "Using configuration from directory $DIR"

header "Installing packages..."
sudo pacman -S --needed git vim rxvt-unicode picom slock xmonad xmobar feh xautolock dmenu clamav

header "Checking yay..."
which yay || install_yay

header "Installing AUR packages"
yay -S --needed awesome-terminal-fonts

header "Installing Vundle.vim..."
if [ ! -d ~/.vim/bundle/Vundle.vim ]; then
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
  echo "Vundle.vim is already installed, consider pulling changes"
fi

header "Installing resource files..."
for resource in .vimrc .xmonad .xmobarrc .zshrc .Xresources set-proxy.sh; do
  install_resource $resource
done

header "Installing vim plugins..."
vim +PluginInstall +qall

header "Installing security..."
sudo cp xorg.conf/* /usr/share/X11/xorg.conf.d
sudo freshclam
