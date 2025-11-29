#!/usr/bin/env bash
set -euo pipefail

########################################
# Universal Bootstrap Script
# Detects OS and runs appropriate setup
########################################

# Version
VERSION="1.0.0"

# Config file
CONFIG_FILE="$HOME/.dev-setup-config"

# Modes
MODE="standard"  # minimal, standard, full
DRY_RUN=false

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
  printf "\n${GREEN}[✓]${NC} %s\n" "$1"
}

warn() {
  printf "\n${YELLOW}[WARN]${NC} %s\n" "$1"
}

error() {
  printf "\n${RED}[ERROR]${NC} %s\n" "$1"
  exit 1
}

########################################
# Show Help
########################################

show_help() {
  cat << EOF
Development Environment Bootstrap v${VERSION}

Usage: ./bootstrap.sh [OPTIONS]

OPTIONS:
  --minimal, -m       Minimal installation (essentials only)
  --standard, -s      Standard installation (default)
  --full, -f          Full installation (everything)
  --dry-run, -d       Preview without installing
  --use-config        Use saved configuration (skip prompts)
  --help, -h          Show this help message
  --version, -v       Show version

EXAMPLES:
  ./bootstrap.sh              # Standard installation with prompts
  ./bootstrap.sh --minimal    # Minimal installation
  ./bootstrap.sh --dry-run    # Preview what will be installed
  ./bootstrap.sh --use-config # Use saved config

MORE INFO:
  https://github.com/username/dev-setup

EOF
  exit 0
}

########################################
# Parse Arguments
########################################

parse_args() {
  USE_CONFIG=false
  
  while [[ $# -gt 0 ]]; do
    case $1 in
      --minimal|-m)
        MODE="minimal"
        shift
        ;;
      --standard|-s)
        MODE="standard"
        shift
        ;;
      --full|-f)
        MODE="full"
        shift
        ;;
      --dry-run|-d)
        DRY_RUN=true
        shift
        ;;
      --use-config)
        USE_CONFIG=true
        shift
        ;;
      --help|-h)
        show_help
        ;;
      --version|-v)
        echo "v${VERSION}"
        exit 0
        ;;
      *)
        echo "Unknown option: $1"
        show_help
        ;;
    esac
  done
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
  
  if [ "$DRY_RUN" = true ]; then
    log "🔍 DRY RUN MODE - No changes will be made"
  fi
  
  log "Detected OS: $OS (Mode: $MODE)"
}

########################################
# Run Platform-Specific Bootstrap
########################################

run_bootstrap() {
  # Pass mode and dry-run flags to platform scripts
  local FLAGS=""
  [ "$DRY_RUN" = true ] && FLAGS="$FLAGS --dry-run"
  FLAGS="$FLAGS --mode $MODE"
  
  case "$OS" in
    macos)
      if [ ! -f "./macos/bootstrap.sh" ]; then
        error "macos/bootstrap.sh not found!"
      fi
      log "Running macOS bootstrap..."
      chmod +x macos/bootstrap.sh
      if [ "$DRY_RUN" = true ]; then
        log "Would execute: ./macos/bootstrap.sh $FLAGS"
      else
        ./macos/bootstrap.sh $FLAGS
      fi
      ;;
    
    linux)
      if [ ! -f "./linux/bootstrap.sh" ]; then
        error "linux/bootstrap.sh not found!"
      fi
      log "Running Linux bootstrap..."
      chmod +x linux/bootstrap.sh
      if [ "$DRY_RUN" = true ]; then
        log "Would execute: ./linux/bootstrap.sh $FLAGS"
      else
        ./linux/bootstrap.sh $FLAGS
      fi
      ;;
    
    windows)
      warn "For Windows, please run the PowerShell script directly:"
      warn "  Set-ExecutionPolicy Bypass -Scope Process -Force"
      warn "  .\\windows\\bootstrap.ps1 $FLAGS"
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
  echo "║        Cross-Platform Setup v${VERSION}     ║"
  echo "╚════════════════════════════════════════╝"
  echo ""
  
  parse_args "$@"
  detect_os
  run_bootstrap
  
  if [ "$DRY_RUN" = false ]; then
    success "Bootstrap completed successfully! 🎉"
    echo ""
    log "💡 Tip: Run './update.sh' to update packages"
    log "💡 Tip: Run 'make help' to see available commands"
  else
    echo ""
    log "🔍 Dry run complete - no changes were made"
    log "Remove --dry-run flag to perform actual installation"
  fi
  echo ""
}

main "$@"

