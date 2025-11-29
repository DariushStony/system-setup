# macOS Setup

This folder contains everything for macOS setup.

## Files

- `bootstrap.sh` - macOS bootstrap script
- `Brewfile` - Homebrew package definitions
- `README.md` - This file

## Quick Start

```bash
cd macos
chmod +x bootstrap.sh
./bootstrap.sh
```

Or use the universal launcher from the root:

```bash
./bootstrap.sh  # Auto-detects macOS
```

**You'll be prompted for:**

- Git name and email
- Dotfiles repository URL (optional - for cloning)
- Dotfiles directory path (can be local or clone destination)

## Brewfile

The `Brewfile` defines all packages to install via Homebrew.

### Structure

```ruby
# Taps
tap "homebrew/core"

# CLI Tools
brew "package-name"

# GUI Applications
cask "app-name"

# Fonts
cask "font-name"
```

### How to Customize

**Add a CLI tool:**
```ruby
brew "your-tool"
```

**Add a GUI app:**
```ruby
cask "your-app"
```

**Comment out packages you don't want:**
```ruby
# brew "unwanted-package"
```

### Useful Commands

```bash
# Test Brewfile
brew bundle check --file=Brewfile

# Install from Brewfile
brew bundle --file=Brewfile

# Generate Brewfile from installed packages
brew bundle dump --file=Brewfile --force

# Cleanup packages not in Brewfile
brew bundle cleanup --file=Brewfile
```

### Package Categories

- **CLI Tools**: Development utilities
- **Programming Languages**: Go, Python (Node.js via fnm)
- **Containers**: Docker, docker-compose
- **Zsh Plugins**: Themes and enhancements
- **GUI Apps**: Code editors, browsers, productivity tools
- **Fonts**: Developer-friendly monospace fonts

### Tips

1. **Keep it organized**: Group similar packages together
2. **Comment packages**: Add comments explaining why you need something
3. **Version control**: Commit changes to track your setup evolution
4. **Share with team**: Use the same Brewfile across your organization

### Finding Packages

```bash
# Search for a formula (CLI tool)
brew search keyword

# Search for a cask (GUI app)
brew search --cask keyword

# Get info about a package
brew info package-name
```

### Optional Packages

Many useful packages are commented out in the Brewfile. Review and uncomment what you need:

- `fzf`, `ripgrep`, `fd` - Modern CLI tools
- `gh` - GitHub CLI
- `pnpm`, `yarn` - Alternative Node package managers
- `kubernetes-cli`, `helm` - Kubernetes tools

