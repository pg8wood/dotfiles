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
#export PS1="\[$(tput setaf 7)\]$USER@\h:[\[$(tput setaf 10)\]\W\[$(tput setaf 7)\]] $\[$(tput sgr0)\] " 


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
