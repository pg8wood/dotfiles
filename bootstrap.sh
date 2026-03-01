#!/usr/bin/env zsh
set -euo pipefail

DOTFILES_REPO="${DOTFILES_REPO:-https://github.com/pg8wood/dotfiles.git}"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/Developer/dotfiles}"

if [ -t 1 ]; then
  RCol=$'\033[0m'
  Gre=$'\033[0;32m'
  Yel=$'\033[0;33m'
  Cya=$'\033[0;36m'
  Red=$'\033[0;31m'
else
  RCol=""
  Gre=""
  Yel=""
  Cya=""
  Red=""
fi

info() {
  echo "  ${Cya}→${RCol} $1"
}

pass() {
  echo "  ${Gre}✓${RCol} $1"
}

warn() {
  echo "  ${Yel}⚠${RCol} $1"
}

fail() {
  echo "  ${Red}✗${RCol} $1"
}

echo ""
echo "Bootstrapping this Mac for dotfiles setup..."
echo ""

if ! xcode-select -p > /dev/null 2>&1; then
  info "Installing Xcode Command Line Tools..."
  xcode-select --install || true

  warn "A macOS dialog should open. Complete the install to continue."
  info "Waiting for Command Line Tools installation..."

  elapsed=0
  timeout=1800
  interval=10
  while ! xcode-select -p > /dev/null 2>&1; do
    sleep "$interval"
    elapsed=$((elapsed + interval))

    if [ $((elapsed % 60)) -eq 0 ]; then
      info "Still waiting... (${elapsed}s elapsed)"
    fi

    if [ "$elapsed" -ge "$timeout" ]; then
      fail "Timed out waiting for Command Line Tools install."
      warn "Re-run bootstrap after CLT finishes."
      exit 1
    fi
  done

  pass "Xcode Command Line Tools installed"
else
  pass "Xcode Command Line Tools already installed"
fi

if ! command -v brew > /dev/null 2>&1; then
  info "Homebrew not found. Installing..."
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  pass "Homebrew installed"
else
  pass "Homebrew already installed"
fi

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if [ -d "$DOTFILES_DIR/.git" ]; then
  info "Dotfiles already exist at $DOTFILES_DIR"
  (cd "$DOTFILES_DIR" && git pull --ff-only) || warn "Couldn't fast-forward existing clone"
  pass "Using existing dotfiles clone"
else
  info "Cloning dotfiles via HTTPS to $DOTFILES_DIR"
  mkdir -p "$(dirname "$DOTFILES_DIR")"
  if git clone "$DOTFILES_REPO" "$DOTFILES_DIR"; then
    pass "Dotfiles cloned"
  else
    fail "Clone failed"
    exit 1
  fi
fi

info "Running install.sh..."
cd "$DOTFILES_DIR"
/bin/bash ./install.sh
