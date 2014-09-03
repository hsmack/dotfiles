#!/usr/bin/env bash

echo 'Dotfiles installer'

if [[ "$1" == "-h" || "$1" == "--help" ]]; then cat <<HELP

Usage: $(basename "$0")

See the README for documentation.
https://github.com/hsmack/dotfiles

Copyright (c) 2014 Henry Chiu
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

#
# enable testing, use $HOME if in production mode
#
TARGET_HOME=$HOME

#
# backup files
#
backup_dir="$TARGET_HOME/backups/$(date "+%Y_%m_%d-%H_%M_%S")/"
backup=

#
# Link files.
#
function link_header() { e_header "Linking files into home directory"; }

#
# verify if file is the same
#
function link_test() {
  [[ "$1" -ef "$2" ]] && echo "same file"
}

#
# perform symlink action
#
function link_do() {
  e_success "Linking .$1"
  ln -sf ${2#$TARGET_HOME/} $TARGET_HOME/.${1}
}

# Copy, link, init, etc.
# this will call named functions as defined by the $1 string.
# <$1>_header, <$1>_test, <$1>_do
#
# the only harmful action that it can do is move an original file out of the 
# $TARGET_HOME directory
function do_stuff() {
  local base dest skip
  local files=($TARGET_HOME/dotfiles/$1/*)
  
  # No files? abort.
  if (( ${#files[@]} == 0 )); then return; fi
  
  # Run _header function only if declared.
  [[ $(declare -f "$1_header") ]] && "$1_header"
  
  # Iterate over files.
  pushd $TARGET_HOME > /dev/null
  for file in "${files[@]}"; do
    base="$(basename $file)"
    dest="$TARGET_HOME/.$base"
    # Run _test function only if declared.
    if [[ $(declare -f "$1_test") ]]; then
      # If _test function returns a string, skip file and print that message.
      skip="$("$1_test" "$file" "$dest")"
      if [[ "$skip" ]]; then
        e_error "Skipping $TARGET_HOME/$base, $skip."
        continue
      fi

      # Destination file already exists in $TARGET_HOME/. Back it up!
      if [[ -e "$dest" ]]; then
        e_arrow "Backing up $TARGET_HOME/$base."
        # Set backup flag, so a nice message can be shown at the end.
        backup=1
        # Create backup dir if it doesn't already exist.
        [[ -e "$backup_dir" ]] || mkdir -p "$backup_dir"
        # Backup file / link / whatever.
        mv "$dest" "$backup_dir"
      fi
    fi
    # Do stuff.
    "$1_do" "$base" "$file"
  done
  popd > /dev/null
}


# Tweak file globbing.
shopt -s dotglob
shopt -s nullglob

do_stuff "link"

# Alert if backups were made.
if [[ "$backup" ]]; then
  echo -e "\nBackups were moved to $TARGET_HOME/${backup_dir#$HOME/}"
fi

#-----------------------------------------------------------------------------
# Finished
#-----------------------------------------------------------------------------

#
# the environment gets kicked off with 
# looks for .profile before .bash_profile
#
if [[ -f ~/.profile ]]; then
  echo "" >> ~/.profile
  echo "source ~/.commonrc" >> ~/.profile
elif [[ -f ~/.bash_profile ]]; then
  echo "" >> ~/.profile
  echo "source ~/.commonrc" >> ~/.bash_profile
else
  e_error "WARNING:  can't find .profile or .bash_profile, you should put 'source ~/.commonrc' into your environment"
fi

#
# kickstart user's environment
#
source ~/.commonrc

# All done!
e_header "All done!"

