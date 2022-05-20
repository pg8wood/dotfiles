# Aliases
source ~/.aliasrc
export PATH="$HOME/dotfiles/scripts:$PATH"

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# Android stuff
export ANDROID_HOME="$HOME/Library/Android/sdk"

# oh-my-zsh 
export ZSH="/Users/patrickgatewood/.oh-my-zsh"

# zsh config
HYPHEN_INSENSITIVE="true"
export UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="false"
setopt nocorrectall

plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Pure Prompt setup
fpath+=$HOME/.zsh/pure # Apple Silicon workaround
ZSH_THEME="" # empty theme is required for pure prompt: https://github.com/sindresorhus/pure#install
autoload -U promptinit; promptinit
prompt pure

# Thank god for vim
bindkey -v
export KEYTIMEOUT=1 

# Google Cloud SDK
if [ -f '/Users/patrickgatewood/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/patrickgatewood/Documents/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/patrickgatewood/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/patrickgatewood/Documents/google-cloud-sdk/completion.zsh.inc'; fi

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

# Custom scripts
export PATH="~/Documents/scripts:$PATH"
