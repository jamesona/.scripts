# ~/.scripts/.bashrc: executed by bash for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# Create the link for the imported bashrc
if ! [ -L ~/.bashrc ]; then
  rm ~/.bashrc
  ln -s ~/.scripts/.bashrc ~/.bashrc
fi

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Define the function we'll use for imports
load() {
  if [ -f $1 ]; then
    . $1
  fi
}

# Load global definitions
load /etc/bashrc

# Load aliases
load ~/.bash_aliases
load ~/.scripts/.bash_aliases

# Load functions
load ~/.bash_functions
load ~/.scripts/.bash_functions

# Load color settings
load ~/.bash_colors
load ~/.scripts/.bash_colors

# Load prompt
load ~/.bash_prompt
load ~/.scripts/.bash_prompt

# Add .scripts to path
PATH=$PATH':/sbin'
PATH=$PATH':~/.scripts'
PATH=$PATH':~/.ip-scripts'
PATH=$PATH':/usr/local/nvm/v5.4.1/bin'

# Suppress nvm errors...
unset NPM_CONFIG_PREFIX


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

# added by travis gem
[ -f ~/.travis/travis.sh ] && source ~/.travis/travis.sh

export NVM_DIR="/home/$(whoami)/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
