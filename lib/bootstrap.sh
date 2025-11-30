#!/usr/bin/env bash
set -euo pipefail

########################################
# Universal Bootstrap Script
# Detects OS and runs appropriate setup
########################################

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Version
VERSION="1.0.0"

# Config file
CONFIG_FILE="$HOME/.system-setup-config"

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
  https://github.com/DariushStony/system-setup

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
# Check Package Selection
########################################

check_package_selection() {
  if [ -f "$SCRIPT_DIR/.package-categories" ]; then
    log "Using package selection from .package-categories"
    echo ""
    # Show current selection briefly
    if [ -f "$SCRIPT_DIR/lib/select-packages.sh" ]; then
      (cd "$SCRIPT_DIR" && "$SCRIPT_DIR/lib/select-packages.sh" --show) 2>/dev/null || true
    fi
    echo ""
    read -p "Do you want to modify your package selection? [y/N] " answer
    answer=${answer:-N}
    case $answer in
      [Yy]* )
        log "Opening package selection..."
        (cd "$SCRIPT_DIR" && "$SCRIPT_DIR/lib/select-packages.sh")
        ;;
      * )
        log "Continuing with current selection..."
        ;;
    esac
  else
    log "No package selection found!"
    echo ""
    warn "⚠️  You haven't selected which packages to install yet."
    echo ""
    echo "You can:"
    echo "  1) Choose packages interactively (recommended)"
    echo "  2) Use a preset (minimal/developer/full)"
    echo "  3) Install all packages (not recommended)"
    echo ""
    read -p "What would you like to do? [1/2/3] " choice
    choice=${choice:-1}
    
    case $choice in
      1)
        log "Opening interactive package selection..."
        (cd "$SCRIPT_DIR" && "$SCRIPT_DIR/lib/select-packages.sh")
        ;;
      2)
        echo ""
        echo "Available presets:"
        echo "  1) Minimal - Essentials only"
        echo "  2) Developer - Recommended for most developers"
        echo "  3) Full - Everything"
        echo ""
        read -p "Choose preset [1/2/3]: " preset
        preset=${preset:-2}
        
        case $preset in
          1)
            log "Applying minimal preset..."
            (cd "$SCRIPT_DIR" && "$SCRIPT_DIR/lib/select-packages.sh" --minimal)
            ;;
          2)
            log "Applying developer preset..."
            (cd "$SCRIPT_DIR" && "$SCRIPT_DIR/lib/select-packages.sh" --developer)
            ;;
          3)
            log "Applying full preset..."
            (cd "$SCRIPT_DIR" && "$SCRIPT_DIR/lib/select-packages.sh" --full)
            ;;
          *)
            log "Invalid preset, using developer preset..."
            (cd "$SCRIPT_DIR" && "$SCRIPT_DIR/lib/select-packages.sh" --developer)
            ;;
        esac
        ;;
      3)
        warn "Installing all packages..."
        # Create a config with everything enabled
        cat > "$SCRIPT_DIR/.package-categories" << EOF
# All packages enabled (default)
INSTALL_ESSENTIALS=true
INSTALL_LANGUAGES=true
INSTALL_DEV_TOOLS=true
INSTALL_BROWSERS=true
INSTALL_EDITORS=true
INSTALL_COMMUNICATION=true
INSTALL_PRODUCTIVITY=true
INSTALL_MEDIA=true
INSTALL_WINDOW_MANAGERS=true
INSTALL_FONTS=true
INSTALL_ZSH_PLUGINS=true
INSTALL_OPTIONAL=true
EOF
        log "Created .package-categories with all packages enabled"
        ;;
      *)
        log "Invalid choice, opening interactive selection..."
        (cd "$SCRIPT_DIR" && "$SCRIPT_DIR/lib/select-packages.sh")
        ;;
    esac
  fi
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
      PLATFORM_SCRIPT="$SCRIPT_DIR/platforms/macos/bootstrap.sh"
      if [ ! -f "$PLATFORM_SCRIPT" ]; then
        error "Platform script not found: $PLATFORM_SCRIPT"
      fi
      log "Running macOS bootstrap..."
      chmod +x "$PLATFORM_SCRIPT"
      if [ "$DRY_RUN" = true ]; then
        log "Would execute: $PLATFORM_SCRIPT $FLAGS"
      else
        "$PLATFORM_SCRIPT" $FLAGS
      fi
      ;;
    
    linux)
      PLATFORM_SCRIPT="$SCRIPT_DIR/platforms/linux/bootstrap.sh"
      if [ ! -f "$PLATFORM_SCRIPT" ]; then
        error "Platform script not found: $PLATFORM_SCRIPT"
      fi
      log "Running Linux bootstrap..."
      chmod +x "$PLATFORM_SCRIPT"
      if [ "$DRY_RUN" = true ]; then
        log "Would execute: $PLATFORM_SCRIPT $FLAGS"
      else
        "$PLATFORM_SCRIPT" $FLAGS
      fi
      ;;
    
    windows)
      PLATFORM_SCRIPT="$SCRIPT_DIR/platforms/windows/bootstrap.ps1"
      warn "For Windows, please run the PowerShell script directly:"
      warn "  Set-ExecutionPolicy Bypass -Scope Process -Force"
      warn "  powershell.exe -ExecutionPolicy Bypass -File $PLATFORM_SCRIPT $FLAGS"
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
  
  # Check package selection (unless dry-run)
  if [ "$DRY_RUN" = false ]; then
    check_package_selection
  fi
  
  # Confirm before proceeding
  echo ""
  echo "════════════════════════════════════════"
  if [ "$DRY_RUN" = true ]; then
    echo "Ready to preview installation (dry-run mode)"
  else
    warn "⚠️  This will modify your system by installing packages and configuring settings."
  fi
  echo "════════════════════════════════════════"
  echo ""
  read -p "Do you want to proceed? [y/N] " proceed
  proceed=${proceed:-N}
  case $proceed in
    [Yy]* )
      log "Starting installation..."
      ;;
    * )
      log "Installation cancelled by user."
      echo ""
      exit 0
      ;;
  esac
  echo ""
  
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

