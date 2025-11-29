#!/usr/bin/env bash
set -euo pipefail

########################################
# COLLECT USER INPUT
########################################

echo ""
echo "╔════════════════════════════════════════╗"
echo "║     macOS Bootstrap Configuration      ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Git Name
read -p "Enter your full name for Git: " GIT_NAME
if [ -z "$GIT_NAME" ]; then
  GIT_NAME="Your Name"
fi

# Git Email
read -p "Enter your email for Git: " GIT_EMAIL
if [ -z "$GIT_EMAIL" ]; then
  GIT_EMAIL="your.email@example.com"
fi

# Dotfiles Repository (optional - for cloning)
read -p "Enter your dotfiles repository URL (or press Enter to skip): " DOTFILES_REPO_URL

# Dotfiles Directory (can be local folder or clone destination)
read -p "Enter dotfiles directory [default: ~/.dotfiles]: " DOTFILES_DIR_INPUT
DOTFILES_DIR="${DOTFILES_DIR_INPUT:-$HOME/.dotfiles}"

echo ""
log "Configuration:"
log "  Git Name: $GIT_NAME"
log "  Git Email: $GIT_EMAIL"
if [ -n "$DOTFILES_REPO_URL" ]; then
  log "  Dotfiles Repo: $DOTFILES_REPO_URL (will clone)"
  log "  Dotfiles Dir: $DOTFILES_DIR"
elif [ -n "$DOTFILES_DIR" ] && [ -d "$DOTFILES_DIR" ]; then
  log "  Dotfiles Dir: $DOTFILES_DIR (local)"
else
  log "  Dotfiles: Will check $DOTFILES_DIR"
fi
echo ""

########################################
# HELPERS
########################################

log() {
  printf "\n\033[1;34m[INFO]\033[0m %s\n" "$1"
}

warn() {
  printf "\n\033[1;33m[WARN]\033[0m %s\n" "$1"
}

error() {
  printf "\n\033[1;31m[ERROR]\033[0m %s\n" "$1"
  exit 1
}

########################################
# 1. Xcode Command Line Tools
########################################

install_xcode_cli() {
  if xcode-select -p &>/dev/null; then
    log "Xcode Command Line Tools already installed."
  else
    log "Installing Xcode Command Line Tools..."
    xcode-select --install || warn "You may need to click through the GUI installer."
    log "Please complete Xcode CLI Tools installation if prompted, then re-run this script if it fails here."
  fi
}

########################################
# 2. Homebrew
########################################

install_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    log "Homebrew already installed."
  else
    log "Installing Homebrew..."
    NONINTERACTIVE=1 \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH (Apple Silicon + Intel)
    if [ -d "/opt/homebrew/bin" ]; then
      eval "$(/opt/homebrew/bin/brew shellenv)"
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    elif [ -d "/usr/local/bin" ]; then
      eval "$(/usr/local/bin/brew shellenv)"
      echo 'eval "$(/usr/local/bin/brew shellenv)"' >> "$HOME/.zprofile"
    fi
  fi
}

########################################
# 3. Brew Bundle
########################################

run_brew_bundle() {
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  BREWFILE="$SCRIPT_DIR/Brewfile"
  
  if [ ! -f "$BREWFILE" ]; then
    warn "No Brewfile found at $BREWFILE. Skipping brew bundle."
    return
  fi

  log "Running brew bundle..."
  brew update
  brew bundle --file="$BREWFILE"
}

########################################
# 4. Dotfiles
########################################

setup_dotfiles() {
  # Clone from repo if URL provided
  if [ -n "$DOTFILES_REPO_URL" ]; then
    if [ -d "$DOTFILES_DIR/.git" ]; then
      log "Dotfiles repo already exists at $DOTFILES_DIR. Pulling latest..."
      git -C "$DOTFILES_DIR" pull --ff-only || warn "Could not pull latest dotfiles."
    else
      log "Cloning dotfiles repo into $DOTFILES_DIR..."
      git clone "$DOTFILES_REPO_URL" "$DOTFILES_DIR"
      log "✓ Dotfiles cloned to: $DOTFILES_DIR"
    fi
  fi
  
  # Check if dotfiles directory exists (either cloned or local)
  if [ ! -d "$DOTFILES_DIR" ]; then
    log "Dotfiles directory not found at $DOTFILES_DIR. Skipping dotfiles setup."
    log "You can manually create it later and re-run this script."
    return
  fi

  # Simple linking example - customize according to your dotfiles structure
  if [ -d "$DOTFILES_DIR" ]; then
    log "Linking dotfiles..."

    # Git
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
      ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
    fi

    # Zsh
    if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
      ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    fi

    # VSCode settings (Mac)
    if [ -f "$DOTFILES_DIR/vscode/settings.json" ]; then
      mkdir -p "$HOME/Library/Application Support/Code/User"
      ln -sf "$DOTFILES_DIR/vscode/settings.json" \
        "$HOME/Library/Application Support/Code/User/settings.json"
    fi
  else
    warn "Dotfiles directory $DOTFILES_DIR not found. Skipping linking."
  fi
}

########################################
# 5. Git Global Config
########################################

configure_git() {
  log "Configuring global git settings..."
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  git config --global pull.rebase false
  git config --global init.defaultBranch main
}

########################################
# 6. macOS Defaults (optional)
########################################

apply_macos_defaults() {
  log "Applying macOS defaults (you can customize/remove these)..."

  # Example tweaks:

  # Show all filename extensions in Finder
  defaults write NSGlobalDomain AppleShowAllExtensions -bool true

  # Fast key repeat
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 15

  # Disable "press-and-hold" for keys in favor of key repeat 
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

  # Finder: show path bar
  defaults write com.apple.finder ShowPathbar -bool true

  # Dock: auto-hide
  defaults write com.apple.dock autohide -bool false

  # Apply changes
  killall Finder || true
  killall Dock || true

  log "macOS defaults applied. Some changes may need logout/login."
}

########################################
# 7. Setup fnm and Install Node.js
########################################

setup_fnm_and_nodejs() {
  log "Setting up fnm and installing Node.js..."
  
  # fnm should be installed via Brewfile
  if ! command -v fnm >/dev/null 2>&1; then
    warn "fnm not found. Make sure brew bundle completed successfully."
    return
  fi
  
  # Setup fnm environment (will be in .zshrc permanently)
  eval "$(fnm env --use-on-cd)"
  
  # Install latest Node.js LTS
  fnm install --lts
  fnm default lts-latest
  
  log "Node.js installed via fnm successfully!"
  log "Run 'node --version' in a new terminal to verify."
}

########################################
# MAIN
########################################

main() {
  log "🚀 Starting macOS bootstrap..."

  install_xcode_cli
  install_homebrew
  run_brew_bundle
  setup_dotfiles
  configure_git
  apply_macos_defaults
  setup_fnm_and_nodejs
  
  log "✅ All done! Open a new terminal session and enjoy your configured macOS."
}

main "$@"
