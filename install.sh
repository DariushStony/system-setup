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
echo "📦 This installer will help you choose which packages to install"
echo ""

# Check if we're already in the repo directory
if [ -f "lib/bootstrap.sh" ] && [ -f "Makefile" ]; then
    echo "✅ Running from repository directory"
    WORKING_DIR="$(pwd)"
else
    # Not in repo, check if git is installed
    if ! command -v git &> /dev/null; then
        echo "❌ Git is not installed. Please install Git first."
        exit 1
    fi
    
    # Check if repo exists in default location
    if [ -d "$INSTALL_DIR" ]; then
        echo "📦 Repository exists at $INSTALL_DIR"
        echo "🔄 Updating..."
        git -C "$INSTALL_DIR" pull
    else
        echo "📥 Cloning repository to $INSTALL_DIR..."
        git clone "$REPO_URL" "$INSTALL_DIR"
    fi
    
    WORKING_DIR="$INSTALL_DIR"
fi

# Run bootstrap from working directory
cd "$WORKING_DIR"
echo ""
echo "🚀 Starting installation..."
echo ""
chmod +x lib/bootstrap.sh
./lib/bootstrap.sh "$@"

echo ""
echo "✅ Setup complete!"
echo ""

# Show cleanup tips only if we cloned to default location
if [ "$WORKING_DIR" = "$INSTALL_DIR" ]; then
    echo "💡 You can delete this repo now if you want:"
    echo "   rm -rf $INSTALL_DIR"
    echo ""
    echo "💡 Or keep it for future updates:"
    echo "   cd $INSTALL_DIR && make update"
else
    echo "💡 To update later:"
    echo "   cd $WORKING_DIR && make update"
fi
echo ""
