#!/usr/bin/env bash
set -euo pipefail

########################################
# Update Script
# Updates packages after initial setup
########################################

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

log() {
  printf "\n${BLUE}[INFO]${NC} %s\n" "$1"
}

success() {
  printf "\n${GREEN}[✓]${NC} %s\n" "$1"
}

warn() {
  printf "\n${YELLOW}[WARN]${NC} %s\n" "$1"
}

########################################
# Detect OS
########################################

detect_os() {
  case "$(uname -s)" in
    Darwin*) OS="macos" ;;
    Linux*)  OS="linux" ;;
    *)       OS="unknown" ;;
  esac
}

########################################
# Update macOS
########################################

update_macos() {
  log "Updating macOS packages..."
  
  if command -v brew >/dev/null 2>&1; then
    log "Updating Homebrew..."
    brew update
    
    log "Upgrading packages..."
    brew upgrade
    
    log "Cleaning up..."
    brew cleanup
    
    success "macOS packages updated!"
  else
    warn "Homebrew not found. Skipping package updates."
  fi
  
  # Update fnm if installed
  if command -v fnm >/dev/null 2>&1; then
    log "Node.js managed by fnm (check 'fnm list-remote' for new versions)"
  fi
}

########################################
# Update Linux
########################################

update_linux() {
  log "Updating Linux packages..."
  
  # Detect distro
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
  else
    warn "Cannot detect Linux distribution"
    return
  fi
  
  case "$DISTRO" in
    ubuntu|debian|pop|linuxmint)
      log "Updating apt packages..."
      sudo apt update
      sudo apt upgrade -y
      sudo apt autoremove -y
      ;;
    
    fedora|rhel|centos)
      log "Updating dnf packages..."
      sudo dnf update -y
      sudo dnf autoremove -y
      ;;
    
    arch|manjaro)
      log "Updating pacman packages..."
      sudo pacman -Syu --noconfirm
      ;;
    
    *)
      warn "Unsupported distribution: $DISTRO"
      ;;
  esac
  
  success "Linux packages updated!"
}

########################################
# Pull latest setup repository
########################################

update_repo() {
  log "Checking for setup updates..."
  
  if [ -d ".git" ]; then
    git pull --ff-only
    success "Setup repository updated!"
  else
    warn "Not a git repository. Skipping repo update."
  fi
}

########################################
# Main
########################################

main() {
  echo ""
  echo "╔════════════════════════════════════════╗"
  echo "║        Update Development Env          ║"
  echo "╚════════════════════════════════════════╝"
  echo ""
  
  detect_os
  
  case "$OS" in
    macos)
      update_repo
      update_macos
      ;;
    
    linux)
      update_repo
      update_linux
      ;;
    
    *)
      warn "Unsupported OS for automatic updates"
      exit 1
      ;;
  esac
  
  echo ""
  success "✅ All updates complete!"
  echo ""
  log "💡 Tip: Run 'make select' to modify your package selection"
  log "💡 Tip: Run 'make install' to install newly selected packages"
  echo ""
}

main "$@"

