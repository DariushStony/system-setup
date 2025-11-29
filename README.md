# 🚀 Cross-Platform Development Setup

Automated one-time setup for development environment on **macOS**, **Linux**, and **Windows**.

One command to install everything: package managers, development tools, applications, and dotfiles.

## 🖥️ Supported Platforms

- ✅ **macOS** (using Homebrew)
- ✅ **Linux** (Ubuntu, Debian, Fedora, Arch)
- ✅ **Windows** (using Winget & Chocolatey)

---

## 🚀 Quick Start

### Method 1: One-Line Remote Install (Easiest)

```bash
curl -fsSL https://raw.githubusercontent.com/DariushStony/system-setup/main/install.sh | bash
```

**That's it!** The installer will:

1. 🎯 Ask which packages you want to install
2. 📦 Show you interactive options (minimal/developer/full presets)
3. ⚡ Install only what you chose (~5-25 minutes depending on selection)

☕ Grab coffee while it installs!

---

### Method 2: Clone and Run

```bash
# Clone
git clone https://github.com/DariushStony/system-setup ~/system-setup
cd ~/system-setup

# Choose packages (recommended)
make select

# Install
make install
```

💡 **First-time users**: The installer will automatically prompt you to select packages if you haven't already!

---

### Method 3: Platform-Specific

**macOS:**

```bash
cd ~/system-setup/platforms/macos
./bootstrap.sh
```

**Linux:**

```bash
cd ~/system-setup/platforms/linux
./bootstrap.sh
```

**Windows (PowerShell as Administrator):**

```powershell
cd ~/system-setup/platforms/windows
.\bootstrap.ps1
```

---

## 📦 What Gets Installed

### Core Development Tools (All Platforms)

- **fnm** - Fast Node.js version manager
- **Node.js LTS** - JavaScript runtime
- **pnpm** - Fast package manager
- **Go** - Go programming language  
- **Python** - Python 3.x
- **Docker** - Containerization
- **Git** - Version control

### CLI Tools

- curl, wget, tree, htop, jq
- tmux - Terminal multiplexer
- starship - Cross-shell prompt
- Zsh plugins (autosuggestions, syntax highlighting)

### GUI Applications (macOS/Linux)

- **Browsers**: Chrome, Firefox, Arc
- **Editors**: VS Code, Cursor, WebStorm
- **Development**: Postman, Proxyman, HTTPie
- **Communication**: Slack, Microsoft Teams
- **Productivity**: Figma, Obsidian, Excalidraw
- **Window Management**: Rectangle, Raycast (macOS)

### Developer Fonts

- JetBrains Mono
- Fira Code
- Cascadia Code

**Total: 50+ packages** (customizable!)

---

## 🎯 Features

### 🎨 Interactive Package Selection ⭐ NEW

The installer **automatically prompts you** to choose packages on first run!

**Three ways to select:**

1. **Interactive** - Choose each category (recommended for beginners)
2. **Preset** - Quick selection:
   - Minimal (essentials only, ~5 min)
   - Developer (recommended, ~15 min)
   - Full (everything, ~25 min)
3. **Install all** - Not recommended (installs everything)

```bash
# Or select before running install:
make select                             # Interactive menu
./lib/select-packages.sh --minimal      # Essentials only
./lib/select-packages.sh --developer    # Recommended
./lib/select-packages.sh --full         # Everything
```

**Package categories:**

- ✅ Essential tools, Programming languages
- ✅ Development tools, Browsers, Editors  
- ✅ Communication, Productivity, Media
- ✅ Window managers, Fonts, Zsh plugins

📖 **See [docs/PACKAGE-SELECTION.md](docs/PACKAGE-SELECTION.md) for complete guide**

---

### ⚙️ Installation Modes

```bash
./lib/bootstrap.sh --minimal    # Essentials only (~5 min)
./lib/bootstrap.sh --standard   # Recommended (~15 min)
./lib/bootstrap.sh --full       # Everything (~25 min)
```

---

### 🔍 Dry Run

Preview without installing:

```bash
make dry-run
./lib/bootstrap.sh --dry-run
```

---

### 🔄 Easy Updates

```bash
make update                 # Update all packages
./lib/update.sh            # Or run directly
```

---

### ⚡ Simple Commands via Makefile

```bash
make help                   # Show all commands
make install                # Install packages
make select                 # Choose packages
make update                 # Update packages
make check                  # Check status
make test                   # Test scripts
```

📖 **See [docs/USAGE.md](docs/USAGE.md) for complete guide**

---

## 📁 Project Structure

```
system-setup/
├── lib/                    # Core scripts
│   ├── bootstrap.sh       # Universal launcher
│   ├── select-packages.sh # Package selection
│   └── update.sh          # Update script
├── platforms/              # Platform-specific
│   ├── macos/             # Homebrew packages
│   ├── linux/             # apt/dnf packages
│   └── windows/           # Winget/Chocolatey
├── docs/                   # Documentation
├── install.sh             # One-line installer
├── Makefile               # Simple commands
└── README.md
```

📖 **See [STRUCTURE.md](STRUCTURE.md) for details**

---

## 🎮 Typical Workflow

### First-Time Install (Recommended)

```bash
make install
# → Automatically prompts for package selection
# → Choose interactive or preset
# → Installs selected packages
```

### Full Control

```bash
make select                 # 1. Choose packages
make dry-run                # 2. Preview
make install                # 3. Install
```

### Quick Preset Install

```bash
./lib/select-packages.sh --developer   # Choose preset
make install                           # Install
```

### Modify Existing Selection

```bash
make install
# → Shows current selection
# → Asks if you want to modify
# → Continues or opens selection menu
```

---

## ⚙️ Configuration

### Interactive Prompts

The bootstrap will ask for:

- Git username and email
- Dotfiles repository URL (optional)
- Dotfiles directory path (optional)

### Saved Configuration

Your preferences are saved to `~/.system-setup-config` for faster re-runs:

```bash
./lib/bootstrap.sh --use-config  # Skip prompts
```

---

## 🔧 Package Customization

Edit platform-specific files to add/remove packages:

**macOS:** `platforms/macos/Brewfile`

```ruby
# Add packages
brew "your-package"
cask "your-app"
```

**Linux:** `platforms/linux/packages.sh`

```bash
BASE_PACKAGES=("package1" "package2")
```

**Windows:** `platforms/windows/packages.ps1`

```powershell
$WINGET_PACKAGES = @("package1", "package2")
```

---

## 🔄 Dotfiles Management

Three options:

### 1. Clone from Repository

```
Dotfiles repo URL: https://github.com/user/dotfiles
Dotfiles directory: ~/.dotfiles
→ Clones and symlinks automatically
```

### 2. Use Existing Local Directory

```
Dotfiles repo URL: (press Enter)
Dotfiles directory: ~/.dotfiles
→ Symlinks from existing directory
```

### 3. Skip Dotfiles

```
Dotfiles repo URL: (press Enter)
Dotfiles directory: (press Enter)
→ Skips dotfiles setup
```

---

## 🆘 Troubleshooting

### macOS

**Homebrew not found?**

```bash
# Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"
# Intel
eval "$(/usr/local/bin/brew shellenv)"
```

**Permission errors?**

```bash
sudo chown -R $(whoami) /opt/homebrew/*
```

### Linux

**fnm not found?**

```bash
source ~/.bashrc  # or ~/.zshrc
fnm install --lts
```

**Docker permission denied?**

```bash
sudo usermod -aG docker $USER
# Log out and log back in
```

### General

**Command not found after install?**

```bash
# Restart your terminal or:
source ~/.zshrc  # or ~/.bashrc
```

**Want to start over?**

```bash
make reset-selection
make select
make install
```

---

## 🧹 Cleanup

### After Installation

```bash
# Optional: Delete the repo
cd ~ && rm -rf ~/.system-setup

# Packages remain installed and working
```

### Keep for Updates

```bash
# Keep repo and update later
cd ~/.system-setup
make update
```

---

## 📚 Documentation

- **[USAGE.md](docs/USAGE.md)** - Complete usage guide
- **[PACKAGE-SELECTION.md](docs/PACKAGE-SELECTION.md)** - Package control guide
- **[STRUCTURE.md](STRUCTURE.md)** - Project structure
- **Platform READMEs** - Platform-specific docs

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Test on your platform
4. Submit a pull request

---

## 📄 License

MIT License - See [LICENSE](LICENSE) file

---

## ⭐ Star this repo if it helped you

**Happy coding!** 🚀

---

## 💡 Tips

- Run `make select` first to customize packages
- Use `make dry-run` to preview before installing
- Update regularly with `make update`
- Check system health: test all commands work
- Customize package files for your needs
- Keep the repo for easy updates

---

**Simple. Fast. Cross-platform.** ✨
