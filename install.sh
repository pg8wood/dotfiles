# Inspired by this awesome setup script: https://github.com/vsbuffalo/dotfiles/blob/master/setup.sh 
source ./scripts/ask.sh

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
if ! command -v brew &> /dev/null
then
    wecho "brew is not installed. Installing now..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

install_brew npm
npm install --global pure-prompt

linkdotfile .aliasrc
linkdotfile .bashrc
linkdotfile .dir_colors
linkdotfile .gitconfig
linkdotfile .gitignore_global
linkdotfile .vimrc
linkdotfile .zshrc

# Gotta do git manually since this repo has its own .git directory
mkdir ~/.git
ln -s git/hooks ~/.git

# Oh My Zsh installation
ohMyZshUrl="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
if ask "Would you like to read the Oh My Zsh install script before continuing? You really should!" Y ; then
   open $ohMyZshUrl
   read -p "Press enter to continue"
fi

if ask "Install Oh My Zsh?" Y ; then 
    sh -c "$(curl -fsSL $ohMyZshUrl)"
fi

echo "Installing zsh-syntax-highlighting"
brew install zsh-syntax-highlighting

echo "Installing Pure Prompt"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"

# Install Playground
cd ./third-party
git clone https://github.com/JohnSundell/Playground.git
cd Playground
swift build -c release
install .build/release/Playground /usr/local/bin/playground
cd ../..
