#!/usr/bin/env zsh
DOTFILES=~/dotfiles
pushd $DOTFILES
STOW_FOLDERS="$(echo */)"
echo $STOW_FOLDERS
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    "Installing $folder"
    stow -D $folder
    stow $folder
done
popd
