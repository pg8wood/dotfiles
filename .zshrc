# Aliases
source ~/dotfiles/.aliasrc
export PATH=/Users/patrickgatewood/Documents/discord-voice-assistant-bot/python-3.6-env/lib/python3.6/site-packages/ffmpeg:$PATH

# Fastlane
export PATH="$HOME/.fastlane/bin:$PATH"

# oh-my-zsh 
export ZSH="/Users/patrickgatewood/.oh-my-zsh"

# zsh config
HYPHEN_INSENSITIVE="true"
export UPDATE_ZSH_DAYS=13
ENABLE_CORRECTION="true"

plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Pure Prompt setup
ZSH_THEME="" # empty theme is required for pure prompt: https://github.com/sindresorhus/pure#install
autoload -U promptinit; promptinit
prompt pure

# Thank god for vim
bindkey -v
export KEYTIMEOUT=1 

# Google Cloud SDK
if [ -f '/Users/patrickgatewood/Documents/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/patrickgatewood/Documents/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/patrickgatewood/Documents/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/patrickgatewood/Documents/google-cloud-sdk/completion.zsh.inc'; fi
