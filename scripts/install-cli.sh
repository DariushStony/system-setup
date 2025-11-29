#!/usr/bin/env bash
set -euo pipefail

########################################
# Install dev-setup CLI Tool
########################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BIN_DIR="$SCRIPT_DIR/bin"
INSTALL_DIR="/usr/local/bin"
CLI_NAME="dev-setup"

# Colors
GREEN='\033[1;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'

log() { printf "${BLUE}[INFO]${NC} %s\n" "$1"; }
success() { printf "${GREEN}[✓]${NC} %s\n" "$1"; }
warn() { printf "${YELLOW}[WARN]${NC} %s\n" "$1"; }
error() { printf "${RED}[ERROR]${NC} %s\n" "$1" >&2; exit 1; }

echo ""
echo "╔════════════════════════════════════════╗"
echo "║   Installing dev-setup CLI Tool        ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Check if running from correct directory
if [ ! -f "$BIN_DIR/dev-setup" ]; then
    error "dev-setup script not found in $BIN_DIR"
fi

# Check if already installed
if [ -L "$INSTALL_DIR/$CLI_NAME" ] || [ -f "$INSTALL_DIR/$CLI_NAME" ]; then
    warn "$CLI_NAME is already installed in $INSTALL_DIR"
    read -p "Reinstall? [y/N] " answer
    case $answer in
        [Yy]*)
            log "Removing old installation..."
            sudo rm -f "$INSTALL_DIR/$CLI_NAME"
            ;;
        *)
            log "Installation canceled"
            exit 0
            ;;
    esac
fi

# Create symlink
log "Creating symlink in $INSTALL_DIR..."

if [ -w "$INSTALL_DIR" ]; then
    ln -s "$BIN_DIR/dev-setup" "$INSTALL_DIR/$CLI_NAME"
else
    sudo ln -s "$BIN_DIR/dev-setup" "$INSTALL_DIR/$CLI_NAME"
fi

# Verify installation
if command -v dev-setup >/dev/null 2>&1; then
    success "dev-setup CLI tool installed successfully!"
    echo ""
    echo "You can now use it from anywhere:"
    echo ""
    echo "  dev-setup install          # Install development environment"
    echo "  dev-setup select           # Choose packages"
    echo "  dev-setup update           # Update packages"
    echo "  dev-setup help             # Show all commands"
    echo ""
    
    # Offer to install shell completion
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    log "Optional: Enable shell completion for tab completion"
    echo ""
    
    if [ -n "$ZSH_VERSION" ] || [ -f "$HOME/.zshrc" ]; then
        read -p "Install Zsh completion? [y/N] " answer
        case $answer in
            [Yy]*)
                if ! grep -q "dev-setup/completions" "$HOME/.zshrc" 2>/dev/null; then
                    echo "" >> "$HOME/.zshrc"
                    echo "# dev-setup CLI completion" >> "$HOME/.zshrc"
                    echo "fpath=($SCRIPT_DIR/completions \$fpath)" >> "$HOME/.zshrc"
                    echo "autoload -U compinit && compinit" >> "$HOME/.zshrc"
                    success "Zsh completion added to ~/.zshrc"
                    log "Restart your shell or run: source ~/.zshrc"
                else
                    warn "Zsh completion already configured"
                fi
                ;;
        esac
    fi
    
    if [ -n "$BASH_VERSION" ] || [ -f "$HOME/.bashrc" ]; then
        read -p "Install Bash completion? [y/N] " answer
        case $answer in
            [Yy]*)
                if ! grep -q "dev-setup/completions" "$HOME/.bashrc" 2>/dev/null; then
                    echo "" >> "$HOME/.bashrc"
                    echo "# dev-setup CLI completion" >> "$HOME/.bashrc"
                    echo "source $SCRIPT_DIR/completions/dev-setup.bash" >> "$HOME/.bashrc"
                    success "Bash completion added to ~/.bashrc"
                    log "Restart your shell or run: source ~/.bashrc"
                else
                    warn "Bash completion already configured"
                fi
                ;;
        esac
    fi
    
    echo ""
    echo "Try: dev-setup doctor"
    echo ""
else
    error "Installation failed. Please check that $INSTALL_DIR is in your PATH"
fi

