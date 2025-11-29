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

# Run bootstrap
cd "$INSTALL_DIR"
chmod +x bootstrap.sh
echo ""
echo "🚀 Starting bootstrap..."
echo ""
./bootstrap.sh "$@"

