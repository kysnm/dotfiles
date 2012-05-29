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
        .gitignore)
            continue;;
        .gitmodules)
            continue;;
        *)
            ln -Fis "$PWD/$dotfile" $HOME
            ;;
    esac
done

wget "http://coderepos.org/share/browser/lang/elisp/init-loader/init-loader.el?format=txt" -O .emacs.d/site-lisp/init-loader.el
wget http://www.emacswiki.org/emacs/download/auto-install.el -P .emacs.d/site-lisp/
