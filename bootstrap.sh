#!/usr/bin/env bash
set -euo pipefail

########################################
# Universal Bootstrap Script
# Detects OS and runs appropriate setup
########################################

# Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m' # No Color

log() {
  printf "\n${BLUE}[INFO]${NC} %s\n" "$1"
}

success() {
  printf "\n${GREEN}[SUCCESS]${NC} %s\n" "$1"
}

warn() {
  printf "\n${YELLOW}[WARN]${NC} %s\n" "$1"
}

error() {
  printf "\n${RED}[ERROR]${NC} %s\n" "$1"
  exit 1
}

########################################
# Detect Operating System
########################################

detect_os() {
  case "$(uname -s)" in
    Darwin*)
      OS="macos"
      ;;
    Linux*)
      OS="linux"
      ;;
    CYGWIN*|MINGW*|MSYS*)
      OS="windows"
      ;;
    *)
      error "Unsupported operating system: $(uname -s)"
      ;;
  esac
  
  log "Detected OS: $OS"
}

########################################
# Run Platform-Specific Bootstrap
########################################

run_bootstrap() {
  case "$OS" in
    macos)
      if [ ! -f "./macos/bootstrap.sh" ]; then
        error "macos/bootstrap.sh not found!"
      fi
      log "Running macOS bootstrap..."
      chmod +x macos/bootstrap.sh
      ./macos/bootstrap.sh
      ;;
    
    linux)
      if [ ! -f "./linux/bootstrap.sh" ]; then
        error "linux/bootstrap.sh not found!"
      fi
      log "Running Linux bootstrap..."
      chmod +x linux/bootstrap.sh
      ./linux/bootstrap.sh
      ;;
    
    windows)
      warn "For Windows, please run the PowerShell script directly:"
      warn "  Set-ExecutionPolicy Bypass -Scope Process -Force"
      warn "  .\\windows\\bootstrap.ps1"
      exit 0
      ;;
    
    *)
      error "Unknown OS: $OS"
      ;;
  esac
}

########################################
# Main
########################################

main() {
  echo ""
  echo "╔════════════════════════════════════════╗"
  echo "║   Development Environment Bootstrap    ║"
  echo "║        Cross-Platform Setup            ║"
  echo "╚════════════════════════════════════════╝"
  echo ""
  
  detect_os
  run_bootstrap
  
  success "Bootstrap completed successfully! 🎉"
}

main "$@"

