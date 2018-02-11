#!/bin/bash

# ***************************
# * Patrick's custom bashrc *
# ***************************


# ***********
# * Aliases *
# ***********

# Note that any command prefixed with 'g' is from the GNU coreutils
alias c='clear'
alias cp='cp -i'
alias docs='cd ~/Documents'
alias drive='cd $GOOGLE_DRIVE'
alias grep='grep --color'
alias l='ls'
alias ll='ls -l'
alias lol='fortune -o | cowsay'
#alias ls='ls -Gh' 				# OSX ls
alias ls='gls --color=auto'		# GNU ls
alias mv='mv -i'
alias notes='cd ~/Documents/notes'
alias rlogin='ssh pg8wood@rlogin.cs.vt.edu'
alias rm='rm -i'
alias s='ls'
alias scd='cd' # because I suck at typing 
alias scripts='cd ~/scripts'

# *****************************
# * Custom interactive prompt *
# *****************************
export PS1="\[$(tput setaf 7)\]$USER@\h:[\[$(tput setaf 10)\]\W\[$(tput setaf 7)\]] $\[$(tput sgr0)\] " 


# *************************
# * Environment Variables *
# *************************
export GOOGLE_DRIVE=~/Google*/Macbook*


# ******************************
# * WORK Environment Variables *
# ******************************
export ANDROID_HOME=/Users/PatrickGatewood/Library/Android/sdk
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/PatrickGatewood/work/gradle-2.13/bin:/Users/PatrickGatewood/Library/Android/sdk/platform-tools/:/Users/PatrickGatewood/Google_Drive/Macbook_Air/scripts/


# *************************************
# * GNU coreutils ls colorized output *
# * Edit ~/.dir_colors to change      *
# *************************************
eval "`gdircolors -b ~/.dir_colors`"


# ***************************
# * git bash tab-completion *
# ***************************
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
