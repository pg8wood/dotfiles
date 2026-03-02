#!/bin/bash
# Patrick's dotfiles installer
# Inspired by https://github.com/vsbuffalo/dotfiles/blob/master/setup.sh

set -e
source ./scripts/ask.sh

# ~~~~~~~~~~~~~~~~~~
# Colors & Formatting
# ~~~~~~~~~~~~~~~~~~
if [ -t 1 ]; then
  RCol=$'\033[0m'       # Reset
  Bold=$'\033[1m'
  Dim=$'\033[2m'

  Red=$'\033[0;31m'
  Gre=$'\033[0;32m'
  Yel=$'\033[0;33m'
  Blu=$'\033[0;34m'
  Mag=$'\033[0;35m'
  Cya=$'\033[0;36m'

  BRed=$'\033[1;31m'
  BGre=$'\033[1;32m'
  BYel=$'\033[1;33m'
  BBlu=$'\033[1;34m'
  BMag=$'\033[1;35m'
  BCya=$'\033[1;36m'
else
  RCol=""
  Bold=""
  Dim=""
  Red=""
  Gre=""
  Yel=""
  Blu=""
  Mag=""
  Cya=""
  BRed=""
  BGre=""
  BYel=""
  BBlu=""
  BMag=""
  BCya=""
fi

# ~~~~~~~~~~~~~~~~~~
# Output helpers
# ~~~~~~~~~~~~~~~~~~
PASS_COUNT=0
FAIL_COUNT=0
SKIP_COUNT=0

phase() {
  echo ""
  echo "${BBlu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RCol}"
  echo "${BBlu}  $1${RCol}"
  echo "${BBlu}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RCol}"
  echo ""
}

step_pass() {
  echo "  ${Gre}✓${RCol} $1"
  PASS_COUNT=$((PASS_COUNT + 1))
}

step_fail() {
  echo "  ${Red}✗${RCol} $1"
  FAIL_COUNT=$((FAIL_COUNT + 1))
}

step_skip() {
  echo "  ${Dim}⊘ $1 (skipped)${RCol}"
  SKIP_COUNT=$((SKIP_COUNT + 1))
}

step_info() {
  echo "  ${Cya}→${RCol} $1"
}

step_warn() {
  echo "  ${Yel}⚠${RCol} $1"
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Look for command, if not found install via homebrew
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
install_brew() {
  if command -v "$1" > /dev/null 2>&1; then
    step_skip "$1 already installed"
  else
    step_info "Installing $1 via homebrew..."
    if brew install "$1" > /dev/null 2>&1; then
      step_pass "$1 installed"
    else
      step_fail "$1 failed to install"
    fi
  fi
}

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Symlink a dotfile from this repo to ~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
linkdotfile() {
  file="$1"
  if [ -L ~/"$file" ]; then
    step_skip "$file already linked"
    return
  fi

  if [ -e ~/"$file" ]; then
    step_warn "$file exists but isn't ours — moving to /tmp"
    mv ~/"$file" /tmp/
  fi

  ln -s "${PWD}/$file" ~/"$file"
  step_pass "$file → ~/$file"
}


# ============================================================
#  Let's go! 🚀
# ============================================================
echo ""
echo "${BMag}╔═════════════════════════════════════════════════════════════════════════════╗${RCol}"
echo "${BMag}║                                                                             ║${RCol}"
echo "${BMag}║  ${BCya}ooooooooo.                 .   o8o                                         ${BMag}║${RCol}"
echo "${BMag}║  ${BCya}\`888   \`Y88.             .o8   \`YP                                         ${BMag}║${RCol}"
echo "${BMag}║  ${BCya} 888   .d88'  .oooo.   .o888oo  '   .oooo.o                                ${BMag}║${RCol}"
echo "${BMag}║  ${BCya} 888ooo88P'  \`P  )88b    888       d88(  \"8                                ${BMag}║${RCol}"
echo "${BMag}║  ${BCya} 888          .oP\"888    888       \`\"Y88b.                                 ${BMag}║${RCol}"
echo "${BMag}║  ${BCya} 888         d8(  888    888 .     o.  )88b                                ${BMag}║${RCol}"
echo "${BMag}║  ${BCya}o888o        \`Y888\"\"8o   \"888\"     8\"\"888P'                                ${BMag}║${RCol}"
echo "${BMag}║                                                                             ║${RCol}"
echo "${BMag}║  ${BCya}oooooooooo.                 .    .o88o.  o8o  oooo                         ${BMag}║${RCol}"
echo "${BMag}║  ${BCya}\`888'   \`Y8b              .o8    888 \`\"  \`\"'  \`888                         ${BMag}║${RCol}"
echo "${BMag}║  ${BCya} 888      888  .ooooo.  .o888oo o888oo  oooo   888   .ooooo.   .oooo.o     ${BMag}║${RCol}"
echo "${BMag}║  ${BCya} 888      888 d88' \`88b   888    888    \`888   888  d88' \`88b d88(  \"8     ${BMag}║${RCol}"
echo "${BMag}║  ${BCya} 888      888 888   888   888    888     888   888  888ooo888 \`\"Y88b.      ${BMag}║${RCol}"
echo "${BMag}║  ${BCya} 888     d88' 888   888   888 .  888     888   888  888    .o o.  )88b     ${BMag}║${RCol}"
echo "${BMag}║  ${BCya}o888bood8P'   \`Y8bod8P'   \"888\" o888o   o888o o888o \`Y8bod8P' 8\"\"888P'     ${BMag}║${RCol}"
echo "${BMag}║                                                                             ║${RCol}"
echo "${BMag}╚═════════════════════════════════════════════════════════════════════════════╝${RCol}"
echo ""


# ──────────────────────────────────────
# Phase 1: Homebrew
# ──────────────────────────────────────
phase "🍺  Phase 1 — Homebrew"

if ! command -v brew &> /dev/null; then
  step_info "Homebrew not found. Installing..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  step_pass "Homebrew installed"
else
  step_skip "Homebrew already installed"
fi

echo ""
step_info "Running ${Bold}brew bundle${RCol} — this may take a while ☕"
echo ""

if brew bundle --file=Brewfile; then
  step_pass "All Homebrew packages installed"
else
  step_warn "Some packages may have failed — check output above"
fi


# ──────────────────────────────────────
# Phase 2: Symlinks
# ──────────────────────────────────────
phase "🔗  Phase 2 — Dotfile Symlinks"

linkdotfile .aliasrc
linkdotfile .bashrc
linkdotfile .dir_colors
linkdotfile .gitconfig
linkdotfile .gitignore_global
linkdotfile .vimrc
linkdotfile .zshrc

# Git hooks need special handling since this repo has its own .git
echo ""
step_info "Linking git hooks..."
if [ ! -d ~/.git ]; then
  mkdir ~/.git
fi

if [ -L ~/.git/hooks ]; then
  step_skip "git hooks already linked"
else
  ln -sf "${PWD}/git/hooks" ~/.git/hooks
  step_pass "git/hooks → ~/.git/hooks"
fi


# ──────────────────────────────────────
# Phase 3: Shell Setup
# ──────────────────────────────────────
phase "🐚  Phase 3 — Shell Setup"

# Oh My Zsh
if [ -d "$HOME/.oh-my-zsh" ]; then
  step_skip "Oh My Zsh already installed"
else
  ohMyZshUrl="https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
  if ask "Would you like to read the Oh My Zsh install script before continuing? You really should!" Y; then
    open "$ohMyZshUrl"
    read -rp "Press enter to continue"
  fi

  if ask "Install Oh My Zsh?" Y; then
    step_info "Installing Oh My Zsh..."
    if RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL "$ohMyZshUrl")" "" --unattended; then
      step_pass "Oh My Zsh installed"
    else
      step_fail "Oh My Zsh install failed"
    fi
  else
    step_skip "Oh My Zsh (declined)"
  fi
fi

step_pass "Pure Prompt installed via Homebrew (Brewfile)"


# ──────────────────────────────────────
# Phase 4: Tools
# ──────────────────────────────────────
phase "🔧  Phase 4 — Tools"

# taipo
if command -v taipo > /dev/null 2>&1; then
  step_skip "taipo already installed"
else
  step_info "Installing taipo (typo-tolerant command runner)..."
  TAIPO_DIR="$HOME/.taipo"
  if [ -d "$TAIPO_DIR" ]; then
    step_skip "taipo repo already cloned"
  else
    git clone https://github.com/pg8wood/taipo.git "$TAIPO_DIR"
  fi
  (cd "$TAIPO_DIR" && ./install.sh)
  step_pass "taipo installed"
fi

# Playground (Swift)
step_info "Installing Playground (Swift REPL helper)..."
PLAYGROUND_DIR="./third-party/Playground"
if [ -d "$PLAYGROUND_DIR" ]; then
  step_skip "Playground repo already cloned"
else
  (cd ./third-party && git clone https://github.com/JohnSundell/Playground.git)
fi
if (cd "$PLAYGROUND_DIR" && swift build -c release > /dev/null 2>&1); then
  install "$PLAYGROUND_DIR/.build/release/Playground" /usr/local/bin/playground
  step_pass "Playground installed to /usr/local/bin/playground"
else
  step_fail "Playground failed to build (may need Xcode installed first)"
fi


# ──────────────────────────────────────
# Phase 5: GitHub Access (Optional)
# ──────────────────────────────────────
phase "🐙  Phase 5 — GitHub Access (Optional)"

if ! command -v gh > /dev/null 2>&1; then
  step_skip "GitHub CLI not installed"
else
  if gh auth status > /dev/null 2>&1; then
    step_skip "GitHub CLI already authenticated"
  else
    if ask "Authenticate GitHub CLI now? (recommended for SSH automation)" Y; then
      if gh auth login --git-protocol ssh --web; then
        step_pass "GitHub CLI authenticated"
      else
        step_fail "GitHub CLI authentication failed"
      fi
    else
      step_skip "GitHub CLI authentication (declined)"
    fi
  fi

  if gh auth status > /dev/null 2>&1; then
    SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
    GITHUB_LOGIN="$(gh api user -q '.login' 2>/dev/null || true)"
    GITHUB_ID="$(gh api user -q '.id' 2>/dev/null || true)"

    if [ -n "$GITHUB_ID" ] && [ -n "$GITHUB_LOGIN" ]; then
      DEFAULT_SSH_COMMENT="${GITHUB_ID}+${GITHUB_LOGIN}@users.noreply.github.com"
    elif [ -n "$GITHUB_LOGIN" ]; then
      DEFAULT_SSH_COMMENT="${GITHUB_LOGIN}@users.noreply.github.com"
    else
      DEFAULT_SSH_COMMENT=""
    fi

    if [ -f "$SSH_KEY_PATH" ] && [ -f "$SSH_KEY_PATH.pub" ]; then
      step_skip "SSH key already exists at ~/.ssh/id_ed25519"
    else
      if ask "Generate a new SSH key for GitHub?" Y; then
        mkdir -p "$HOME/.ssh"
        chmod 700 "$HOME/.ssh"

        if [ -n "$DEFAULT_SSH_COMMENT" ]; then
          printf "SSH key comment/email [%s]\n" "$DEFAULT_SSH_COMMENT"
        else
          printf "SSH key comment/email\n"
        fi
        read -r SSH_KEY_COMMENT </dev/tty
        SSH_KEY_COMMENT="${SSH_KEY_COMMENT:-$DEFAULT_SSH_COMMENT}"

        if ssh-keygen -t ed25519 -C "$SSH_KEY_COMMENT" -f "$SSH_KEY_PATH" -N ""; then
          step_pass "SSH key generated"
        else
          step_fail "SSH key generation failed"
        fi
      else
        step_skip "SSH key generation (declined)"
      fi
    fi

    if [ -f "$SSH_KEY_PATH.pub" ]; then
      step_info "Adding SSH key to ssh-agent..."
      eval "$(ssh-agent -s)" > /dev/null
      if ssh-add --apple-use-keychain "$SSH_KEY_PATH" > /dev/null 2>&1 || ssh-add -K "$SSH_KEY_PATH" > /dev/null 2>&1 || ssh-add "$SSH_KEY_PATH" > /dev/null 2>&1; then
        step_pass "SSH key added to ssh-agent"
      else
        step_warn "Couldn't auto-add SSH key to ssh-agent"
      fi

      if ask "Upload this SSH key to GitHub now?" Y; then
        SSH_KEY_TITLE="$(scutil --get ComputerName 2>/dev/null || hostname)-$(date +%Y-%m-%d)"
        if gh ssh-key add "$SSH_KEY_PATH.pub" --title "$SSH_KEY_TITLE" > /dev/null 2>&1; then
          step_pass "SSH key uploaded to GitHub"
        else
          step_warn "SSH key upload may have failed (possibly already uploaded)"
        fi
      else
        step_skip "SSH key upload to GitHub (declined)"
      fi

      if ask "Prefer SSH for github.com git remotes?" Y; then
        git config --global url."git@github.com:".insteadOf "https://github.com/"
        if git remote get-url origin > /dev/null 2>&1; then
          origin_url="$(git remote get-url origin)"
          if [[ "$origin_url" == https://github.com/* ]]; then
            ssh_origin="${origin_url/https:\/\/github.com\//git@github.com:}"
            git remote set-url origin "$ssh_origin"
          fi
        fi
        step_pass "Git configured to prefer SSH for GitHub"
      else
        step_skip "SSH remote rewrite (declined)"
      fi
    fi
  else
    step_skip "GitHub auth-dependent SSH setup"
  fi
fi


# ──────────────────────────────────────
# Phase 6: Secrets
# ──────────────────────────────────────
phase "🔐  Phase 6 — Secrets"

if [ -f "$HOME/.gitconfig_private" ]; then
  step_skip "~/.gitconfig_private already exists"
else
  step_info "Creating ~/.gitconfig_private for private git identity..."

  DEFAULT_GIT_NAME="$(git config --global user.name 2>/dev/null || true)"
  DEFAULT_GIT_EMAIL="$(git config --global user.email 2>/dev/null || true)"

  if command -v gh > /dev/null 2>&1 && gh auth status > /dev/null 2>&1; then
    GH_NAME="$(gh api user -q '.name' 2>/dev/null || true)"
    GH_LOGIN="$(gh api user -q '.login' 2>/dev/null || true)"
    GH_ID="$(gh api user -q '.id' 2>/dev/null || true)"

    if [ -n "$GH_NAME" ] && [ "$GH_NAME" != "null" ]; then
      DEFAULT_GIT_NAME="$GH_NAME"
    fi
    if [ -n "$GH_ID" ] && [ -n "$GH_LOGIN" ]; then
      DEFAULT_GIT_EMAIL="${GH_ID}+${GH_LOGIN}@users.noreply.github.com"
    elif [ -n "$GH_LOGIN" ]; then
      DEFAULT_GIT_EMAIL="${GH_LOGIN}@users.noreply.github.com"
    fi
  fi

  DEFAULT_GIT_NAME="${DEFAULT_GIT_NAME:-Your Name}"
  DEFAULT_GIT_EMAIL="${DEFAULT_GIT_EMAIL:-your-id+username@users.noreply.github.com}"

  printf "Git author name [%s]\n" "$DEFAULT_GIT_NAME"
  read -r GIT_NAME </dev/tty
  GIT_NAME="${GIT_NAME:-$DEFAULT_GIT_NAME}"

  printf "Git author email [%s]\n" "$DEFAULT_GIT_EMAIL"
  read -r GIT_EMAIL </dev/tty
  GIT_EMAIL="${GIT_EMAIL:-$DEFAULT_GIT_EMAIL}"

  cat > "$HOME/.gitconfig_private" <<EOL
[user]
    name = $GIT_NAME
    email = $GIT_EMAIL
# Optional:
# [commit]
#     gpgsign = true
#
# Optional:
# signingkey = YOUR_SIGNING_KEY_ID
EOL

  chmod 600 "$HOME/.gitconfig_private"
  step_pass "~/.gitconfig_private created"
fi

if [ -f "$HOME/.zshrc_private" ]; then
  step_skip "~/.zshrc_private already exists"
else
  step_info "Creating ~/.zshrc_private for private environment variables..."

  touch "$HOME/.zshrc_private"
  chmod 600 "$HOME/.zshrc_private"

  cat <<'EOL' >> "$HOME/.zshrc_private"
# Private environment variables

# Replace with your actual phone number (including country code)
export PHONE_NUMBER="+1234567890"

# Add other private environment variables below
# export LINEAR_API_KEY="your-key-here"
EOL

  step_pass "~/.zshrc_private created (edit it to set your secrets)"
fi


# ──────────────────────────────────────
# Phase 7: Manual Installs Reminder
# ──────────────────────────────────────
phase "📱  Phase 7 — Manual Installs"

echo "  ${Yel}The following apps need to be installed manually from the"
echo "  Mac App Store or direct download. See ${Bold}manual-installs.md${RCol}${Yel}"
echo "  for clickable links.${RCol}"
echo ""

echo "  ${Bold}Development${RCol}"
echo "  ${Dim}├─${RCol} Copilot for Xcode  ${Dim}(GitHub release)${RCol}"
echo "  ${Dim}├─${RCol} Asset Catalog Creator Pro  ${Dim}(Mac App Store)${RCol}"
echo "  ${Dim}└─${RCol} Store Screens  ${Dim}(Mac App Store)${RCol}"
echo ""
echo "  ${Bold}Productivity${RCol}"
echo "  ${Dim}├─${RCol} Yoink  ${Dim}(Mac App Store)${RCol}"
echo "  ${Dim}├─${RCol} Vimari  ${Dim}(Mac App Store)${RCol}"
echo "  ${Dim}└─${RCol} CardPointers  ${Dim}(Mac App Store)${RCol}"
echo ""
echo "  ${Bold}Fun${RCol}"
echo "  ${Dim}└─${RCol} emochi  ${Dim}(Mac App Store)${RCol}"
echo ""
echo ""
echo "  ${Yel}🔐 Don't forget to populate your secrets!${RCol}"
echo "  ${Dim}→${RCol}  ${Bold}~/.zshrc_private${RCol}"
echo "  ${Dim}   Set your PHONE_NUMBER, LINEAR_API_KEY, and any other private env vars.${RCol}"
echo ""


# ──────────────────────────────────────
# Summary
# ──────────────────────────────────────
echo ""
echo "${BMag}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RCol}"
echo ""
echo "  ${BGre}✓ ${PASS_COUNT} completed${RCol}    ${Dim}⊘ ${SKIP_COUNT} skipped${RCol}    ${BRed}✗ ${FAIL_COUNT} failed${RCol}"
echo ""

if [ "$FAIL_COUNT" -gt 0 ]; then
  echo "  ${Yel}⚠  Some steps failed. Scroll up to check the details.${RCol}"
else
  echo "  ${BGre}✨ All done! Welcome to your new machine.${RCol}"
fi

echo ""
echo "${BMag}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RCol}"
echo ""
