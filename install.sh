#!/usr/bin/env bash
# One-line remote installer
# Usage: curl -fsSL https://raw.githubusercontent.com/username/repo/main/install.sh | bash

set -e

REPO_URL="https://github.com/username/dev-setup"
INSTALL_DIR="$HOME/.dev-setup"

echo "╔════════════════════════════════════════╗"
echo "║   Development Environment Installer    ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git first."
    exit 1
fi

# Clone or update repository
if [ -d "$INSTALL_DIR" ]; then
    echo "📦 Repository exists. Updating..."
    git -C "$INSTALL_DIR" pull
else
    echo "📥 Cloning repository..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# Option 1: Install CLI tool (recommended)
cd "$INSTALL_DIR"
echo ""
echo "Choose installation method:"
echo "  1) Install CLI tool (recommended - use 'dev-setup' command anywhere)"
echo "  2) Run bootstrap directly"
echo ""
read -p "Choice [1/2]: " choice

case $choice in
    2)
        echo ""
        echo "🚀 Running bootstrap directly..."
        echo ""
        chmod +x lib/bootstrap.sh
        ./lib/bootstrap.sh "$@"
        ;;
    *)
        echo ""
        echo "📦 Installing CLI tool..."
        echo ""
        chmod +x scripts/install-cli.sh
        ./scripts/install-cli.sh
        echo ""
        echo "✅ CLI installed! Now run: dev-setup install"
        ;;
esac

