# Linux Setup

This folder contains everything for Linux setup.

## Files

- `bootstrap.sh` - Linux bootstrap script
- `packages.sh` - Package definitions and configuration
- `README.md` - This file

## Quick Start

```bash
cd linux
chmod +x bootstrap.sh
./bootstrap.sh
```

Or use the universal launcher from the root:

```bash
./lib/bootstrap.sh  # Auto-detects Linux and prompts for package selection
```

**You'll be prompted for:**

- **Package selection** - Choose which packages to install (interactive/preset/all)
- Git name and email
- Dotfiles repository URL (optional - for cloning)
- Dotfiles directory path (can be local or clone destination)

💡 **Tip:** Run `make select` first to choose packages, then run `make install`

## packages.sh

The `packages.sh` file defines all packages to install on Linux.

### Structure

```bash
# Base packages (essential tools)
BASE_PACKAGES=(
  "curl"
  "wget"
  "git"
)

# Development tools
DEV_PACKAGES=(
  "build-essential"
  "golang-go"
)

# CLI tools
CLI_TOOLS=(
  "httpie"
  "neovim"
)

# Configuration flags
INSTALL_DOCKER=true
INSTALL_VSCODE=true
```

### How to Customize

**Add a package to a category:**

```bash
BASE_PACKAGES=(
  "curl"
  "wget"
  "your-package"  # Add here
)
```

**Enable/disable features:**

```bash
INSTALL_DOCKER=false  # Skip Docker installation
INSTALL_OH_MY_ZSH=true  # Install Oh-My-Zsh
```

**Add custom package list:**

```bash
CUSTOM_PACKAGES=(
  "postgresql"
  "redis"
  "nginx"
)
```

### Supported Distributions

The bootstrap script auto-detects and adapts for:

- **Ubuntu / Debian / Pop!_OS / Linux Mint** → `apt`
- **Fedora / RHEL / CentOS** → `dnf`
- **Arch / Manjaro** → `pacman`

### Package Categories

1. **BASE_PACKAGES** - Essential CLI tools
2. **DEV_PACKAGES** - Compilers and build tools
3. **CLI_TOOLS** - Development utilities
4. **ZSH_PLUGINS** - Zsh enhancements
5. **OPTIONAL_PACKAGES** - Commented out packages

### Configuration Options

```bash
# Docker
INSTALL_DOCKER=true

# VS Code
INSTALL_VSCODE=true
INSTALL_CHROME=false

# Zsh
INSTALL_OH_MY_ZSH=true
CHANGE_SHELL_TO_ZSH=true

# Node.js
INSTALL_FNM=true
INSTALL_NODE_LTS=true
```

### Package Name Differences

Some packages have different names across distributions:

| Tool | Ubuntu/Debian | Fedora | Arch |
|------|---------------|--------|------|
| fd | fd-find | fd-find | fd |
| Go | golang-go | golang | go |
| C Compiler | build-essential | gcc | base-devel |

The bootstrap script handles these automatically.

### Adding Custom Packages

Edit `packages.sh`:

```bash
# Add your custom packages
CUSTOM_PACKAGES=(
  "postgresql"
  "redis-server"
  "nginx"
)
```

Then update the bootstrap script to install them:

```bash
# In bootstrap-linux.sh
for pkg in "${CUSTOM_PACKAGES[@]}"; do
  sudo apt install -y "$pkg"  # Ubuntu
done
```

### Tips

1. **Test on a VM first** - Before running on production
2. **Keep it minimal** - Only install what you need
3. **Document why** - Add comments for unusual packages
4. **Version control** - Commit changes to track evolution

### Finding Packages

**Ubuntu/Debian:**

```bash
apt search keyword
apt show package-name
```

**Fedora:**

```bash
dnf search keyword
dnf info package-name
```

**Arch:**

```bash
pacman -Ss keyword
pacman -Si package-name
```
