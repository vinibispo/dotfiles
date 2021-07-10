#!/usr/bin/env sh
DOTFILES=~/dotfiles
pushd $DOTFILES
STOW_FOLDERS="$(echo */)"
for folder in $(echo $STOW_FOLDERS | sed "s/,/ /g")
do
    echo "Removing $folder"
    stow -D $folder
done
popd
