# 🚀 Usage Guide

Quick reference for all the ways to use this setup.

---

## ⚡ Quick Start

### One-Line Install (Recommended)

```bash
curl -fsSL https://raw.githubusercontent.com/username/dev-setup/main/install.sh | bash
```

**What happens:**
1. Script detects your OS
2. **Prompts you to select packages** (interactive/preset/all)
3. Installs only what you selected

### Manual Install

```bash
git clone https://github.com/username/dev-setup.git
cd dev-setup
./lib/bootstrap.sh
```

**First-time users:** The bootstrap will automatically ask you to choose packages if no selection exists!

---

## 📦 Package Selection (Automatic)

### First-Time Installation

When you run the installer for the first time without a `.package-categories` file, you'll see:

```
[INFO] No package selection found!

⚠️  You haven't selected which packages to install yet.

You can:
  1) Choose packages interactively (recommended)
  2) Use a preset (minimal/developer/full)
  3) Install all packages (not recommended)

What would you like to do? [1/2/3]
```

**Option 1 - Interactive Selection:**
- Walks through each package category
- You choose Yes/No for each
- Most control

**Option 2 - Preset Selection:**
- Minimal: Essentials only (~5 min, ~1 GB)
- Developer: Recommended (~15 min, ~5 GB)
- Full: Everything (~25 min, ~6 GB)

**Option 3 - Install All:**
- Installs everything without filtering
- Not recommended for most users

### Existing Selection

If you already have a `.package-categories` file, the installer will:

```
[INFO] Using package selection from .package-categories

Current selection:
[✓] Essential tools
[✓] Programming languages
...

Do you want to modify your package selection? [y/N]
```

Press `y` to change, or Enter to continue with current selection.

---

## 📋 Installation Modes

### Standard (Default)

```bash
./lib/bootstrap.sh
```

Uses package selection (prompts if needed).

### Minimal

```bash
./lib/bootstrap.sh --minimal
```

Only essential tools (git, editor, shell).

### Full

```bash
./lib/bootstrap.sh --full
```

Everything including optional packages.

---

## 🔧 Command Options

### Preview Before Installing

```bash
./bootstrap.sh --dry-run
```

See what will be installed without making changes.

### Skip Prompts

```bash
./bootstrap.sh --use-config
```

Use saved configuration (no interactive prompts).

### Help & Version

```bash
./bootstrap.sh --help      # Show all options
./bootstrap.sh --version   # Show version
```

---

## 🎯 Using Make Commands

If you have `make` installed:

```bash
make install        # Standard installation
make install-min    # Minimal installation
make install-full   # Full installation
make update         # Update all packages
make dry-run        # Preview installation
make check          # Check package status
make test           # Test scripts
make help           # Show all commands
```

---

## 🔄 Updating

### Update Everything

```bash
./update.sh
```

Updates:

- Repository (git pull)
- Packages (Homebrew/apt/dnf)
- Node.js (via fnm)

### Update via Make

```bash
make update
```

---

## 📝 Configuration File

The bootstrap saves your configuration to `~/.dev-setup-config`:

```bash
# Example ~/.dev-setup-config
GIT_NAME="John Doe"
GIT_EMAIL="john@example.com"
DOTFILES_REPO="git@github.com:username/dotfiles.git"
DOTFILES_DIR="~/.dotfiles"
MODE="standard"
```

### Skip Prompts on Re-run

```bash
./bootstrap.sh --use-config
```

---

## 🎨 Customization

### Customize Packages

**macOS:**

```bash
vim macos/Brewfile
./bootstrap.sh
```

**Linux:**

```bash
vim linux/packages.sh
./bootstrap.sh
```

**Windows:**

```powershell
notepad windows/packages.ps1
.\windows\bootstrap.ps1
```

---

## 🔍 Dry Run Examples

### Preview Standard Install

```bash
./bootstrap.sh --dry-run
```

### Preview Minimal Install

```bash
./bootstrap.sh --minimal --dry-run
```

### Preview Full Install

```bash
./bootstrap.sh --full --dry-run
```

---

## 💡 Tips & Tricks

### 1. Test Before Committing

```bash
make test          # Syntax check
make dry-run       # Preview changes
```

### 2. Update Regularly

```bash
make update        # Weekly updates
```

### 3. Check Package Status

```bash
make check         # See what's missing
```

### 4. Use Config File

Save time on re-runs by using saved configuration.

### 5. Combine Flags

```bash
./bootstrap.sh --minimal --dry-run    # Preview minimal install
```

---

## 🆘 Troubleshooting

### Script Won't Run

```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

### Permission Errors (Linux)

```bash
sudo ./bootstrap.sh    # Not recommended
# Or fix ownership:
sudo chown -R $USER /usr/local
```

### Reset Configuration

```bash
rm ~/.dev-setup-config
./bootstrap.sh
```

### Force Update

```bash
cd dev-setup
git pull --force
./bootstrap.sh
```

---

## 📚 More Information

- **Main README**: [README.md](README.md)
- **Platform Guides**:
  - [macOS](macos/README.md)
  - [Linux](linux/README.md)
  - [Windows](windows/README.md)

---

## 🎯 Common Workflows

### New Machine Setup (First Time)

```bash
curl -fsSL https://url/install.sh | bash
# 1. Choose package selection method when prompted
# 2. Select packages (interactive or preset)
# 3. Wait for installation
# Done!
```

### Re-run or Update Existing Setup

```bash
cd ~/dev-setup
make install
# 1. Shows current selection
# 2. Asks if you want to modify [y/N]
# 3. Press Enter to continue or 'y' to change
```

### Select Packages Before Installing

```bash
cd ~/dev-setup
make select          # Choose packages first
make dry-run         # Preview what will be installed
make install         # Install
```

### Change Package Selection Later

```bash
cd ~/dev-setup
make select          # Re-select packages
make install         # Install newly selected packages
```

### Add New Packages to Brewfile

```bash
# 1. Edit package file
vim platforms/macos/Brewfile

# 2. Preview
make dry-run

# 3. Install
make install
```

### Share with Team

```bash
# 1. Fork repository
# 2. Customize packages
# 3. Share repo URL
# Team runs: curl -fsSL your-url/install.sh | bash
# They'll be prompted to select packages automatically!
```

---

**Happy coding!** 🎉
