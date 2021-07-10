#!/usr/bin/env zsh
DOTFILES=~/dotfiles
pushd $DOTFILES
STOW_FOLDERS="$(echo */)"
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    stow -D $folder
    stow $folder
done
popd
