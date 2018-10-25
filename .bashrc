#!/bin/bash

# ***************************
# * Patrick's custom bashrc *
# ***************************


# ***********
# * Aliases *
# ***********
source ~/dotfiles/.aliasrc

# ******************************
# * Custom interactive prompt  *
# * result: user@host:[PWD##*/]*
# ******************************
export PS1="\[$(tput setaf 7)\]$USER@\h:[\[$(tput setaf 10)\]\W\[$(tput setaf 7)\]] $\[$(tput sgr0)\] " 


# *************************
# * Environment Variables *
# *************************
export GOOGLE_DRIVE=/Users/PatrickGatewood/Google_Drive/Macbook_Pro/


# ******************************
# * WORK Environment Variables *
# ******************************
export ANDROID_HOME=/Users/PatrickGatewood/Library/Android/sdk
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/PatrickGatewood/work/gradle-2.13/bin:/Users/PatrickGatewood/Library/Android/sdk/platform-tools/:$GOOGLE_DRIVE/scripts/


# *************************************
# * GNU coreutils ls colorized output *
# * Edit ~/.dir_colors to change      *
# *************************************
eval "`gdircolors -b $GOOGLE_DRIVE/config/.dir_colors`"


# ***************************
# * git bash tab-completion *
# ***************************
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
fi
if [ -f `brew --prefix`/etc/bash_completion.d/git-flow-completion.bash ]; then
  . `brew --prefix`/etc/bash_completion.d/git-flow-completion.bash
fi
