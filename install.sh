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

# Choose installation method
cd "$INSTALL_DIR"
echo ""
echo "╔════════════════════════════════════════╗"
echo "║     Choose Installation Method         ║"
echo "╚════════════════════════════════════════╝"
echo ""
echo "1) Quick setup (one-time, no CLI install)"
echo "   → Installs packages now, you can delete repo after"
echo ""
echo "2) Install CLI tool + packages"
echo "   → Adds 'dev-setup' command for future updates"
echo ""
read -p "Choice [1/2, default=1]: " choice
choice=${choice:-1}

case $choice in
    2)
        echo ""
        echo "📦 Installing CLI tool..."
        chmod +x scripts/install-cli.sh
        ./scripts/install-cli.sh
        echo ""
        echo "✅ Now run: dev-setup install"
        ;;
    *)
        echo ""
        echo "🚀 Running quick setup (one-time)..."
        echo ""
        chmod +x lib/bootstrap.sh
        ./lib/bootstrap.sh "$@"
        echo ""
        echo "✅ Setup complete!"
        echo ""
        echo "💡 Tip: You can delete this repo now if you want:"
        echo "   rm -rf $INSTALL_DIR"
        echo ""
        echo "💡 Or keep it for future updates:"
        echo "   cd $INSTALL_DIR && make update"
        ;;
esac

