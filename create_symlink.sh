#!/bin/sh
# https://raw.github.com/sugyan/dotfiles/master/create_symlink.sh
cd $(dirname $0)
for dotfile in .?*; do
    case $dotfile in
        *.elc)
            continue;;
        ..)
            continue;;
        .git)
            continue;;
        .sample)
            continue;;
        *)
            ln -Fis "$PWD/$dotfile" $HOME
            ;;
    esac
done
