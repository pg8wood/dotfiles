# Homebrew path fix for Apple Silicon
eval $(/opt/homebrew/bin/brew shellenv)

# Aliases
source ~/.aliasrc
export PATH="$HOME/Developer/dotfiles/scripts:$PATH"

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# Android stuff
export ANDROID_HOME="$HOME/Library/Android/sdk"

# oh-my-zsh 
export ZSH="$HOME/.oh-my-zsh"

# zsh config
HYPHEN_INSENSITIVE="true"
export UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="false"
setopt nocorrectall

plugins=(
  git
)

# Private RC for secrets 🤫
if [ -f "$HOME/.zshrc_private" ]; then
    source "$HOME/.zshrc_private"
fi

# Pure Prompt setup
fpath+=("$(brew --prefix)/share/zsh/site-functions")
ZSH_THEME="" # empty theme is required for pure prompt: https://github.com/sindresorhus/pure#install
autoload -U promptinit; promptinit
prompt pure

# Terminal vim mode
# -----------------
bindkey -v
export KEYTIMEOUT=1 

# Make TAB cycle between autocompletion suggestions. This MUST be after either the Pure Prompt setup or the 
# vim mode binding otherwise it doesn't work
bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# History search is more useful than "redisplay" (vim redo)
bindkey "^R" history-incremental-search-backward
# -----------------

# GPG Commit Signing
export GPG_TTY=$(tty)

# Get rid of Xamarin UI Tests incoming connection alerts
simfirewall() {
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate off
/usr/libexec/ApplicationFirewall/socketfilterfw --add /Applications/Xcode.app/Contents/MacOS/Xcode
/usr/libexec/ApplicationFirewall/socketfilterfw --add /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app/Contents/MacOS/Simulator
/usr/libexec/ApplicationFirewall/socketfilterfw --add /Applications/Visual\ Studio.app/Contents/MacOS/VisualStudio
sudo /usr/libexec/ApplicationFirewall/socketfilterfw --setglobalstate on
}
export PATH="/usr/local/opt/ruby/bin:$PATH"

# .NET hates ZSH
export PATH=$HOME/.dotnet/tools:$PATH

# VS Code
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Linter shenanigans
linter() {
  if [ "$1" == "on" ]; then 
      export LINTER_ENABLED=1
  elif [ "$1" == "off" ]; then 
      export LINTER_ENABLED=0
  else
      echo "Try again with 'on' or 'off'"
  fi
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"

# taipo command-not-found hook
if [ -f "$HOME/.taipo/command_not_found_handler.zsh" ]; then
    source "$HOME/.taipo/command_not_found_handler.zsh"
fi

# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# AI Maestro PATH (added by installer)
export PATH="$HOME/.local/bin:$PATH"
