#!/bin/bash

echo 'Dotfiles'

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP

Usage: $(basename "$0")

See the README for documentation.
https://github.com/hsmack/dotfiles

Copyright (c) 2013 Henry Chiu
Licensed under the MIT license.
HELP
exit; fi

#-----------------------------------------------------------------------------
# Functions
#-----------------------------------------------------------------------------

# Logging stuff.
function e_header()   { echo -e "\n\033[1m$@\033[0m"; }
function e_success()  { echo -e " \033[1;32m✔\033[0m  $@"; }
function e_error()    { echo -e " \033[1;31m✖\033[0m  $@"; }
function e_arrow()    { echo -e " \033[1;33m➜\033[0m  $@"; }

e_header "Linking files into home directory"
ln -nfs ~/dotfiles/link/ackrc ~/.ackrc
ln -nfs ~/dotfiles/link/aliases ~/.aliases
ln -nfs ~/dotfiles/link/commonrc ~/.commonrc
ln -nfs ~/dotfiles/link/env ~/.env
ln -nfs ~/dotfiles/link/functions ~/.functions
ln -nfs ~/dotfiles/link/gemrc ~/.gemrc
ln -nfs ~/dotfiles/link/gitconfig ~/.gitconfig
ln -nfs ~/dotfiles/link/irbrc ~/.irbrc
ln -nfs ~/dotfiles/link/vimrc ~/.vimrc


#-----------------------------------------------------------------------------
# Finished
#-----------------------------------------------------------------------------

# kickstart the environment
if [[ -f ~/.profile ]]; then
  echo "" >> ~/.profile
  echo "source ~/.commonrc" >> ~/.profile
elif [[ -f ~/.bash_profile ]]; then
  echo "" >> ~/.profile
  echo "source ~/.commonrc" >> ~/.bash_profile
else
  e_error "WARNING:  can't find .profile or .bash_profile, you should put 'source ~/.commonrc' into your environment"
fi

source ~/.commonrc

# All done!
e_header "All done!"

