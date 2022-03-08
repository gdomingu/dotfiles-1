#!/bin/bash

DIR="$(dirname "${BASH_SOURCE[0]}")"
DIR="$(cd $DIR 2> /dev/null && pwd -P)"

# git
git config --global include.path "${DIR}/git/config"

function lnk() {
  (
    unlink "$2"
    ln -s "$1" "$2"
  )
}

# vim
lnk ${DIR}/vim  ~/.vim
lnk ${DIR}/vim/.vimrc ~/.vimrc

# shell
lnk ${DIR}/shell/.zprofile ~/.zprofile
lnk ${DIR}/shell/.bash_profile ~/.bash_profile

chsh_zsh() {
    if [[ $(getent passwd "$USER") != */zsh ]]
    then
        sudo -n chsh -s /bin/zsh $USER
    fi
}

case "$OSTYPE" in
    darwin*)
        echo "skipping brew install, takes too damn long"
        # brew install gh git git-lfs the_silver_searcher vim watch
        source ~/.zprofile
    ;;
    linux*)
        chsh_zsh
        source ~/.zprofile
    ;;
esac

if [[ -n $CODESPACES ]]
then
    cp .zshrc .zshrc-codespaces
    cp .zshrc .bashrc-codespaces
fi
