# 🚀 Cross-Platform Development Setup

Automated development environment setup for **macOS**, **Linux**, and **Windows**.

One command to set up your entire dev environment with package managers, dotfiles, and sensible defaults.

## 🖥️ Supported Platforms

- ✅ **macOS** (using Homebrew)
- ✅ **Linux** (Ubuntu, Debian, Fedora, Arch)
- ✅ **Windows** (using Winget & Chocolatey)

## 🚀 Quick Start

### Universal (Auto-detects OS)

```bash
# Clone this repo
git clone <your-repo-url> ~/dev-setup
cd ~/dev-setup

# Run the universal bootstrap
chmod +x bootstrap.sh
./bootstrap.sh
```

### Platform-Specific

**macOS:**

```bash
cd macos
chmod +x bootstrap.sh
./bootstrap.sh
```

**Linux:**

```bash
cd linux
chmod +x bootstrap.sh
./bootstrap.sh
```

**Windows (PowerShell as Administrator):**

```powershell
cd windows
Set-ExecutionPolicy Bypass -Scope Process -Force
.\bootstrap.ps1
```

**That's it!** ☕ Grab some coffee while it installs everything (~10-20 minutes).

## 📦 What Gets Installed

### Core Development Tools (All Platforms)

- **fnm** - Fast Node.js version manager (40x faster than nvm!)
- **Node.js LTS** - JavaScript runtime
- **Go** - Go programming language
- **Python** - Python 3.x
- **Docker** - Containerization platform
- **Git** - Version control with custom config
- **VS Code** - Code editor

### CLI Tools (All Platforms)

- **curl**, **wget** - Download utilities
- **httpie** - Modern HTTP client
- **jq** - JSON processor
- **ripgrep** - Fast grep alternative
- **fd** - Fast find alternative
- **fzf** - Fuzzy finder
- **bat** - Modern cat with syntax highlighting
- **neovim** - Modern vim

### macOS Specific

- **Homebrew** - Package manager
- **Cursor** - AI-powered editor
- **Arc Browser** - Modern web browser
- **Raycast** - Spotlight replacement
- **Rectangle** - Window manager
- **iTerm2** / **Warp** - Modern terminals
- **Postman**, **Proxyman** - API tools

### Linux Specific

- **Docker** - Native containerization
- **tmux** - Terminal multiplexer
- **Zsh** with Oh-My-Zsh
- Package managers: **apt**, **dnf**, or **pacman** (auto-detected)

### Windows Specific

- **Winget** & **Chocolatey** - Package managers
- **Windows Terminal** - Modern terminal
- **PowerToys** - Windows utilities
- **PowerShell 7** - Modern shell
- **WSL** (optional) - Linux subsystem

### Developer Fonts (All Platforms)

- **JetBrains Mono**
- **Fira Code**
- **Cascadia Code**

### Communication & Productivity (Where Available)

- **Slack**, **Microsoft Teams**
- **Figma**, **Obsidian**, **Excalidraw**
- **Spotify**, **VLC**
- **Chrome**, **Firefox**, **Edge**

**Total packages vary by platform:**

- macOS: **60+ packages**
- Linux: **40+ packages**
- Windows: **50+ packages**

## 📁 Repository Structure

```
dev-setup/
├── bootstrap.sh                # ⭐ Universal launcher (auto-detects OS)
│
├── macos/                      # 🍎 macOS
│   ├── bootstrap.sh           # macOS bootstrap script
│   ├── Brewfile               # Homebrew packages (60+)
│   └── README.md              # Package management guide
│
├── linux/                      # 🐧 Linux
│   ├── bootstrap.sh           # Linux bootstrap script
│   ├── packages.sh            # Package lists (40+)
│   └── README.md              # Package management guide
│
├── windows/                    # 🪟 Windows
│   ├── bootstrap.ps1          # Windows bootstrap script
│   ├── packages.ps1           # Winget + Chocolatey packages (50+)
│   └── README.md              # Package management guide
│
├── .gitignore                  # Git ignore file
├── LICENSE                     # MIT License
└── README.md                   # 📖 Main documentation (this file)
```

## 🔧 What the Bootstrap Scripts Do

### All Platforms

1. ✅ Installs **package manager** (Homebrew/apt/winget)
2. ✅ Installs **Git** and development tools
3. ✅ Installs **fnm** (Fast Node Manager)
4. ✅ Installs **Node.js LTS** via fnm
5. ✅ Installs **Docker** and container tools
6. ✅ Installs **programming languages** (Go, Python)
7. ✅ Installs **CLI utilities** (curl, wget, httpie, etc.)
8. ✅ Installs **GUI applications** (VS Code, browsers, etc.)
9. ✅ Clones your **dotfiles** repository
10. ✅ Symlinks dotfiles to appropriate locations
11. ✅ Configures **Git** globally

### Platform-Specific

**macOS:**

- Installs Xcode Command Line Tools
- Runs `brew bundle` (installs 60+ packages from Brewfile)
- Applies macOS defaults (fast key repeat, Finder settings)
- Installs fonts via Homebrew cask

**Linux:**

- Auto-detects distro (Ubuntu/Debian/Fedora/Arch)
- Uses appropriate package manager (apt/dnf/pacman)
- Installs Oh-My-Zsh with plugins
- Changes default shell to zsh
- Installs GUI apps where available

**Windows:**

- Installs Winget and Chocolatey
- Sets up PowerShell profile with fnm
- Installs fonts via Chocolatey
- Configures Windows Terminal
- Optional: Installs WSL (Windows Subsystem for Linux)

## ⚙️ Configuration

### Interactive Setup (Recommended)

The bootstrap scripts now **prompt for user input** - no need to edit files!

When you run a bootstrap script, it will ask:

```
Enter your full name for Git: John Doe
Enter your email for Git: john@example.com
Enter your dotfiles repository URL (or press Enter to skip): git@github.com:user/dotfiles.git
Enter dotfiles directory [default: ~/.dotfiles]: 
```

### Dotfiles Setup (Optional but Recommended)

The bootstrap scripts support both **remote** and **local** dotfiles management.

#### Option 1: Clone from Repository (Recommended)

1. Create a separate repository for your dotfiles (e.g., `github.com/username/dotfiles`)
2. Structure it like this:

   ```
   dotfiles/
   ├── git/.gitconfig
   ├── zsh/.zshrc
   ├── vscode/settings.json
   └── README.md
   ```

3. When running bootstrap:

   ```bash
   Enter your dotfiles repository URL: git@github.com:username/dotfiles.git
   Enter dotfiles directory [default: ~/.dotfiles]: ▊  # Press Enter for default
   ```

4. The script clones and symlinks automatically

#### Option 2: Use Local Directory

If you already have dotfiles locally:

```bash
Enter your dotfiles repository URL: ▊  # Press Enter to skip
Enter dotfiles directory [default: ~/.dotfiles]: ~/my-configs  # Your local path
```

#### Option 3: Skip Dotfiles

Press Enter twice to use defaults (will skip if directory doesn't exist):

```bash
Enter your dotfiles repository URL: ▊
Enter dotfiles directory [default: ~/.dotfiles]: ▊
```

**Example dotfiles repositories for inspiration:**

- [mathiasbynens/dotfiles](https://github.com/mathiasbynens/dotfiles)
- [holman/dotfiles](https://github.com/holman/dotfiles)
- [paulirish/dotfiles](https://github.com/paulirish/dotfiles)

### Package Customization

Edit the package lists in platform-specific folders:

**macOS** - Edit `macos/Brewfile`:

```ruby
brew "your-package"        # Add CLI tool
cask "your-app"            # Add GUI app
# brew "unwanted"          # Comment out unwanted packages
```

**Linux** - Edit `linux/packages.sh`:

```bash
BASE_PACKAGES=(
  "curl"
  "your-package"  # Add your package
)
INSTALL_DOCKER=true  # Configuration flags
```

**Windows** - Edit `windows/packages.ps1`:

```powershell
$WINGET_PACKAGES = @(
    @{Id="Your.Package"; Name="Your Package"}
)
$CHOCOLATEY_PACKAGES = @("your-package")
$INSTALL_WSL = $false  # Configuration flags
```

See each platform's `README.md` for detailed package management guides.

## 📚 Documentation

- **[SETUP-INSTRUCTIONS.md](SETUP-INSTRUCTIONS.md)** - Comprehensive setup guide
- **[CHANGELOG.md](CHANGELOG.md)** - Recent changes and updates

## 🔍 Key Features

### ⚡️ Fast Node.js Management with fnm

```bash
fnm install --lts        # Install latest LTS
fnm install 18           # Install specific version
fnm use 20               # Switch versions
fnm default 20           # Set default
```

Auto-switches Node versions based on `.node-version` or `.nvmrc` files!

### 🎨 macOS Defaults Applied

- Show all file extensions in Finder
- **Fast key repeat** (perfect for Vim users)
- Disable press-and-hold (enables key repeat)
- Show path bar in Finder
- Custom Dock settings

### 🔗 Dotfiles Management

The bootstrap scripts support both remote and local dotfiles:

**Clone from Repository:**

- Provide your dotfiles repo URL when prompted
- Script clones to specified directory (default: `~/.dotfiles`)
- Automatically creates symlinks

**Use Local Directory:**

- Skip the repository URL prompt (press Enter)
- Enter path to your existing dotfiles directory
- Script creates symlinks from that location

**Benefits:**

- ✅ Flexible: Remote or local dotfiles
- ✅ Version controlled (if using repo)
- ✅ Portable across machines
- ✅ Customizable location
- ✅ Easy to update and maintain

## 📦 Optional Packages

In `Brewfile`, many useful tools are commented out. Uncomment what you need:

```ruby
# Modern CLI tools
brew "fzf"           # Fuzzy finder
brew "ripgrep"       # Fast grep
brew "jq"            # JSON processor
brew "gh"            # GitHub CLI

# Smart navigation
brew "zoxide"        # Smart cd
brew "bat"           # Better cat

# Package managers
brew "pnpm"
brew "yarn"

# Kubernetes
brew "kubernetes-cli"
brew "helm"
```

## 🛠️ Useful Commands

```bash
# Update everything
brew update && brew upgrade && brew cleanup

# Reinstall from Brewfile
brew bundle

# Generate new Brewfile from installed apps
brew bundle dump --force

# List installed packages
brew list --formula    # CLI tools
brew list --cask       # GUI apps
```

## 🔄 Updating Your Setup

**macOS:**

```bash
cd ~/dev-setup
git pull
brew bundle          # Install any new packages
source ~/.zshrc      # Reload shell config
```

**Linux:**

```bash
cd ~/dev-setup
git pull
# Re-run bootstrap or install packages manually
source ~/.zshrc
```

**Windows:**

```powershell
cd ~\dev-setup
git pull
# Re-run bootstrap-windows.ps1
. $PROFILE  # Reload PowerShell profile
```

## 🔄 Platform Comparison

| Feature | macOS | Linux | Windows |
|---------|-------|-------|---------|
| Package Manager | Homebrew | apt/dnf/pacman | Winget + Chocolatey |
| Node Manager | fnm | fnm | fnm |
| Shell | Zsh | Zsh/Bash | PowerShell |
| Terminal | iTerm2/Warp | Native | Windows Terminal |
| Docker | Docker Desktop | Native Docker | Docker Desktop |
| Fonts | Homebrew Cask | Manual/Package | Chocolatey |
| Setup Time | ~15 min | ~10 min | ~20 min |
| Packages | 60+ | 40+ | 50+ |

## 🆘 Troubleshooting

### macOS

**fnm not working?**

```bash
source ~/.zshrc
fnm install --lts
```

**Homebrew command not found?**

```bash
# Apple Silicon
eval "$(/opt/homebrew/bin/brew shellenv)"
# Intel
eval "$(/usr/local/bin/brew shellenv)"
```

**Permission errors?**

```bash
sudo chown -R $(whoami) /opt/homebrew/*  # Apple Silicon
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

**Zsh not default shell?**

```bash
chsh -s $(which zsh)
```

### Windows

**Script execution error?**

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
```

**Winget not found?**

- Install "App Installer" from Microsoft Store
- Or download from: <https://aka.ms/getwinget>

**fnm not found after install?**

```powershell
# Refresh PATH
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
```

**Need admin rights?**

- Right-click PowerShell → "Run as Administrator"

### Universal

**Git clone fails (SSH)?**

```bash
# Use HTTPS instead
DOTFILES_REPO_URL="https://github.com/username/dotfiles.git"
```

**Want to start fresh?**

```bash
# macOS: Remove Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"

# Linux: Remove packages via your package manager
# Windows: Uninstall via Apps & Features

# Then re-run bootstrap
```

## 🎯 Why This Setup?

- **🚀 Fast**: fnm loads instantly (nvm can add 1-2s to shell startup)
- **🔧 Automated**: One command sets up everything
- **🌍 Cross-platform**: Works on macOS, Linux, and Windows
- **📦 Reproducible**: Same setup on any machine
- **🔄 Version controlled**: Track your environment changes
- **🎨 Sensible defaults**: Platform-specific tweaks for developers
- **🧹 Clean**: No bloat, only what you need
- **🔀 Flexible**: Easy to customize per platform

## 🤝 Contributing

This is a personal setup, but feel free to fork and customize for your needs!

## 📄 License

MIT

## 🔗 Resources

**Package Managers:**

- [Homebrew](https://brew.sh) (macOS)
- [Winget](https://aka.ms/getwinget) (Windows)
- [Chocolatey](https://chocolatey.org) (Windows)

**Development Tools:**

- [fnm](https://github.com/Schniz/fnm) - Fast Node Manager
- [oh-my-zsh](https://ohmyz.sh) - Zsh framework
- [Starship](https://starship.rs) - Cross-platform prompt

**Platform-Specific:**

- [Raycast](https://raycast.com) - macOS launcher
- [PowerToys](https://aka.ms/powertoys) - Windows utilities
- [Windows Terminal](https://aka.ms/terminal) - Modern terminal for Windows

---

**Enjoy your new dev setup on any platform!** 🎉

For platform-specific package management, see the README in each platform folder:

- [macOS Setup Guide](macos/README.md)
- [Linux Setup Guide](linux/README.md)
- [Windows Setup Guide](windows/README.md)
