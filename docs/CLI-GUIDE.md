# 🚀 dev-setup CLI Tool Guide

Your complete development environment setup as a simple CLI tool!

---

## 📥 Installation

### Option 1: Local Install (Recommended)

```bash
# Clone the repository
git clone https://github.com/username/dev-setup.git
cd dev-setup

# Install CLI tool globally
./install-cli.sh

# Now use from anywhere
dev-setup help
```

### Option 2: One-Line Install

```bash
# Install directly from GitHub
curl -fsSL https://raw.githubusercontent.com/username/dev-setup/main/install.sh | bash
```

### Option 3: Use Without Installing

```bash
# Just run from the directory
./dev-setup help
```

---

## 📖 Usage

### Basic Commands

```bash
# Show help
dev-setup help

# Check system status
dev-setup doctor

# List available packages
dev-setup list
```

### Installation Workflow

```bash
# 1. Choose packages (interactive)
dev-setup select

# 2. Preview what will be installed
dev-setup install --dry-run

# 3. Install
dev-setup install

# 4. Update later
dev-setup update
```

---

## 🎯 Commands Reference

### `dev-setup install [options]`

Install your development environment.

**Options:**

- `--minimal` - Install essentials only (~5 min)
- `--standard` - Standard installation (default, ~15 min)
- `--full` - Install everything (~25 min)
- `--dry-run` - Preview without installing
- `--use-config` - Use saved configuration (skip prompts)

**Examples:**

```bash
dev-setup install                    # Standard installation
dev-setup install --minimal          # Minimal installation
dev-setup install --dry-run          # Preview only
dev-setup install --use-config       # Use saved config
```

---

### `dev-setup select [preset]`

Choose which packages to install.

**Presets:**

- `--minimal` - Essentials only
- `--developer` - Recommended for developers
- `--full` - Everything

**Examples:**

```bash
dev-setup select                     # Interactive menu
dev-setup select --minimal           # Apply minimal preset
dev-setup select --developer         # Apply developer preset
dev-setup select --full              # Apply full preset
```

**Interactive mode:**

```
╔════════════════════════════════════════╗
║     Package Selection Tool             ║
╚════════════════════════════════════════╝

1) Interactive selection (choose each category)
2) Preset: Minimal (essentials only)
3) Preset: Developer (recommended)
4) Preset: Full (everything)
5) Show current selection
6) Edit config file manually
7) Exit
```

---

### `dev-setup update`

Update all installed packages.

**What it does:**

- Updates package manager (Homebrew/apt/dnf)
- Updates all installed packages
- Updates Node.js via fnm
- Cleans up old versions

**Example:**

```bash
dev-setup update
```

---

### `dev-setup list`

List available packages and current selection.

**Example:**

```bash
dev-setup list

📦 Available Packages

Current selection:
[✓] Essential tools
[✓] Programming languages
[✓] Development tools
[ ] Browsers
[✓] Editors & IDEs
...
```

---

### `dev-setup check`

Check package installation status.

**Example:**

```bash
dev-setup check
```

---

### `dev-setup config`

Manage configuration.

**Subcommands:**

- `show` - Display current configuration
- `edit` - Edit configuration file
- `reset` - Reset all configuration

**Examples:**

```bash
dev-setup config show          # Show configuration
dev-setup config edit          # Edit in $EDITOR
dev-setup config reset         # Reset everything
```

---

### `dev-setup doctor`

Check system and dependencies.

**Example:**

```bash
dev-setup doctor

🏥 System Check

[✓] OS: macOS
[✓] git installed
[✓] curl installed
[✓] Homebrew installed
[✓] Config file exists
[✓] Package selection exists
```

---

### `dev-setup clean`

Clean up temporary files.

**Example:**

```bash
dev-setup clean
```

---

### `dev-setup uninstall`

Uninstall the CLI tool (packages remain installed).

**Example:**

```bash
dev-setup uninstall
```

---

### `dev-setup version`

Show version information.

**Example:**

```bash
dev-setup version
# dev-setup version 1.0.0
```

---

## 🎮 Real-World Examples

### Example 1: New Machine Setup

```bash
# Install CLI
curl -fsSL https://url/install.sh | bash

# Choose packages
dev-setup select

# Install
dev-setup install

# Done! ✅
```

### Example 2: Minimal Server Setup

```bash
dev-setup select --minimal
dev-setup install
```

### Example 3: Full Developer Setup

```bash
dev-setup select --developer
dev-setup install --dry-run    # Preview
dev-setup install              # Install
```

### Example 4: Customize Then Install

```bash
# Start with a preset
dev-setup select --developer

# Check what's selected
dev-setup list

# Customize if needed
dev-setup config edit

# Install
dev-setup install
```

### Example 5: Regular Maintenance

```bash
# Weekly updates
dev-setup update

# Check status
dev-setup check

# Verify system
dev-setup doctor
```

---

## 💡 Tips & Tricks

### 1. Quick Status Check

```bash
dev-setup doctor && dev-setup list
```

### 2. Save Time with Presets

```bash
# Apply preset, then install with saved config
dev-setup select --developer
dev-setup install --use-config
```

### 3. Test Before Installing

```bash
dev-setup install --dry-run
```

### 4. Different Setups for Different Machines

**Work laptop:**

```bash
dev-setup select --developer
dev-setup install
```

**Personal laptop:**

```bash
dev-setup select --full
dev-setup install
```

**Server:**

```bash
dev-setup select --minimal
dev-setup install
```

### 5. Quick Reset

```bash
dev-setup config reset
dev-setup select
```

---

## 🔧 Configuration Files

### Global Config

**Location:** `~/.dev-setup-config`

Stores your preferences:

- Git username and email
- Dotfiles repository URL
- Dotfiles directory
- Other settings

### Package Selection

**Location:** `.package-categories` (in project directory)

Controls which packages to install:

```bash
INSTALL_ESSENTIALS=true
INSTALL_LANGUAGES=true
INSTALL_DEV_TOOLS=true
INSTALL_BROWSERS=false
...
```

---

## 🆘 Troubleshooting

### Command Not Found

```bash
# Check if installed
which dev-setup

# Reinstall
cd /path/to/dev-setup
./install-cli.sh
```

### Permission Errors

```bash
# Use sudo for installation
sudo ./install-cli.sh
```

### Reset Everything

```bash
dev-setup config reset
rm -rf ~/.dev-setup-config
dev-setup select
dev-setup install
```

### Check System Status

```bash
dev-setup doctor
```

---

## 📚 Advanced Usage

### Custom Installation Location

```bash
# Edit install-cli.sh
INSTALL_DIR="$HOME/.local/bin"

# Then install
./install-cli.sh
```

### Add to Different Shell

```bash
# Add to PATH manually
echo 'export PATH="$PATH:/path/to/dev-setup"' >> ~/.zshrc
source ~/.zshrc
```

### Automated Setup (CI/CD)

```bash
# Non-interactive installation
dev-setup select --minimal
dev-setup install --use-config
```

---

## 🎯 Command Aliases

Add to your `.zshrc` or `.bashrc`:

```bash
# Short aliases
alias ds='dev-setup'
alias dsi='dev-setup install'
alias dsu='dev-setup update'
alias dsl='dev-setup list'
alias dsc='dev-setup check'
alias dsd='dev-setup doctor'

# Now use:
ds help
dsi --minimal
dsu
```

---

## 🔄 Updating the CLI Tool

```bash
# Go to installation directory
cd /path/to/dev-setup

# Pull latest changes
git pull origin main

# Reinstall CLI
./install-cli.sh

# Verify
dev-setup version
```

---

## 📦 What Gets Installed

Run `dev-setup list` to see available packages organized by category:

- **Essential Tools**: git, curl, wget, tree, htop
- **Programming Languages**: Node.js (fnm), Go, Python
- **Development Tools**: Docker, Postman, Proxyman
- **Browsers**: Chrome, Firefox, Arc
- **Editors**: VS Code, Cursor, WebStorm
- **Communication**: Slack, Teams
- **Productivity**: Figma, Obsidian, Excalidraw
- **Media**: Spotify, VLC
- **Window Managers**: Rectangle, Raycast
- **Fonts**: JetBrains Mono, Fira Code
- **Zsh Plugins**: Autosuggestions, syntax highlighting
- **Optional**: Fun CLI tools

---

## 🎉 Benefits

✅ **Simple** - One command to rule them all
✅ **Fast** - Quick commands, no typing paths
✅ **Global** - Use from any directory
✅ **Consistent** - Same commands on all platforms
✅ **Professional** - Proper CLI tool structure
✅ **Documented** - Comprehensive help system

---

## 🚀 Quick Reference

```bash
# Installation
dev-setup select                    # Choose packages
dev-setup install                   # Install
dev-setup update                    # Update

# Information
dev-setup list                      # Show packages
dev-setup check                     # Check status
dev-setup doctor                    # System check

# Configuration
dev-setup config show               # View config
dev-setup config edit               # Edit config
dev-setup config reset              # Reset

# Maintenance
dev-setup clean                     # Clean up
dev-setup uninstall                 # Uninstall CLI
dev-setup version                   # Show version
dev-setup help                      # Show help
```

---

**Now you have a professional CLI tool!** 🎉

Use `dev-setup` from anywhere on your system.
