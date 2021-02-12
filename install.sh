# Inspired by this awesome setup script: https://github.com/vsbuffalo/dotfiles/blob/master/setup.sh 

RCol='\033[0m'
Gre='\033[0;32m'
Red='\033[0;31m'
Yel='\033[0;33m'

# ~~~~~~~~~~~~~~~~~~
# Printing functions 
# ~~~~~~~~~~~~~~~~~~
function gecho {
  echo "${Gre}[message] $1${RCol}"
}

function yecho {
  echo "${Yel}[warning] $1${RCol}"
}

function wecho {
  # red, but don't exit 1
  echo "${Red}[error] $1${RCol}"
}


function recho {
  echo "${Red}[error] $1${RCol}"
  exit 1
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Look for command line tool, if not install via homebrew
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function install_brew {
  (command -v $1 > /dev/null  && gecho "$1 found...") || 
    (yecho "$1 not found, installing via homebrew..." && brew install $1)
}


function linkdotfile {
  file="$1"
  if [ -e ~/$file ]; then 
    yecho "$file found, but it's not ours. Moving it to /tmp"
    mv ~/$1 /tmp
  fi

  if [ ! -e ~/$file -a ! -L ~/$file ]; then
      yecho "linking $file... " >&2
      ln -s ${PWD}/$file ~/$file
  else
      gecho "ignoring $file because it's already linked" >&2
  fi
}


# Installation actions
install_brew npm
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
npm install --global pure-prompt

linkdotfile .aliasrc
linkdotfile .bashrc
linkdotfile .dir_colors
linkdotfile .git
linkdotfile .gitconfig
linkdotfile .gitignore_global
linkdotfile .vimrc
linkdotfile .zshrc
