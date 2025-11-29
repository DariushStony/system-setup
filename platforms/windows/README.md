# Windows Setup

This folder contains everything for Windows setup.

## Files

- `bootstrap.ps1` - Windows bootstrap script (PowerShell)
- `packages.ps1` - Package definitions and configuration
- `README.md` - This file

## Quick Start

**PowerShell as Administrator:**

```powershell
cd windows
Set-ExecutionPolicy Bypass -Scope Process -Force
.\bootstrap.ps1
```

Or use the universal launcher from the root:

```bash
./bootstrap.sh  # Will guide you to run Windows script
```

**You'll be prompted for:**

- Git name and email
- Dotfiles repository URL (optional - for cloning)
- Dotfiles directory path (can be local or clone destination)

## packages.ps1

The `packages.ps1` file defines all packages to install on Windows.

### Structure

```powershell
# Winget packages (GUI apps + some CLI)
$WINGET_PACKAGES = @(
    @{Id="Microsoft.VisualStudioCode"; Name="VS Code"}
)

# Chocolatey packages (CLI tools + fonts)
$CHOCOLATEY_PACKAGES = @(
    "wget",
    "curl"
)

# Configuration
$INSTALL_WSL = $false
$INSTALL_DOCKER = $true
```

### How to Customize

**Add a Winget package:**

```powershell
$WINGET_PACKAGES = @(
    @{Id="Package.ID"; Name="Display Name"},
    @{Id="Your.Package"; Name="Your Package"}  # Add here
)
```

**Add a Chocolatey package:**

```powershell
$CHOCOLATEY_PACKAGES = @(
    "wget",
    "your-package"  # Add here
)
```

**Enable/disable features:**

```powershell
$INSTALL_WSL = $true  # Install Windows Subsystem for Linux
$INSTALL_DOCKER = $false  # Skip Docker Desktop
```

### Package Managers

**Winget (Windows Package Manager):**

- Official Microsoft package manager
- Best for GUI applications
- Integrated with Windows 11

**Chocolatey:**

- Community-driven package manager
- Best for CLI tools and fonts
- Large package repository

### Package Categories

#### Winget Packages

- Development tools (VS Code, Docker, Postman)
- Programming languages (Node.js, Go, Python)
- Browsers (Chrome, Firefox, Edge)
- Communication (Slack, Teams)
- Productivity (Figma, Obsidian)
- Media (Spotify, VLC)
- Utilities (PowerToys, fnm)

#### Chocolatey Packages

- CLI tools (wget, curl, httpie, jq)
- Modern alternatives (ripgrep, fd, fzf, bat)
- Editors (neovim)
- Fonts (JetBrains Mono, Fira Code, Cascadia Code)

### Finding Package IDs

**Winget:**

```powershell
# Search for a package
winget search "package name"

# Get package ID
winget show "package name"
```

**Chocolatey:**

```powershell
# Search
choco search keyword

# Get info
choco info package-name
```

Or browse online:

- Winget: <https://winget.run>
- Chocolatey: <https://community.chocolatey.org/packages>

### Configuration Options

```powershell
# WSL (Windows Subsystem for Linux)
$INSTALL_WSL = $false  # Set to $true to install Ubuntu

# Docker Desktop
$INSTALL_DOCKER = $true

# fnm (Fast Node Manager)
$INSTALL_FNM = $true

# PowerShell Profile
$SETUP_POWERSHELL_PROFILE = $true
```

### Optional Packages

Uncomment in `packages.ps1`:

```powershell
$OPTIONAL_WINGET = @(
    @{Id="Git.Git"; Name="Git"},
    @{Id="GitHub.GitHubDesktop"; Name="GitHub Desktop"}
)

$OPTIONAL_CHOCO = @(
    "docker-compose",
    "make",
    "postgresql"
)
```

### Adding Custom Packages

**Method 1: Edit packages.ps1**

```powershell
$WINGET_PACKAGES = @(
    # ... existing packages ...
    @{Id="YourApp.Name"; Name="Your App"}
)
```

**Method 2: Install manually**

```powershell
# Via Winget
winget install --id Package.ID

# Via Chocolatey
choco install package-name -y
```

### Tips

1. **Run as Administrator** - Required for installation
2. **Check package IDs** - IDs are case-sensitive
3. **Test first** - Try installing one package before running full script
4. **Keep updated** - Run `winget upgrade --all` regularly
5. **Use WSL for Linux tools** - Many Linux tools work better in WSL

### Package Manager Commands

**Winget:**

```powershell
# Install
winget install --id Package.ID

# Update
winget upgrade --all

# List installed
winget list

# Uninstall
winget uninstall --id Package.ID
```

**Chocolatey:**

```powershell
# Install
choco install package-name -y

# Update
choco upgrade all -y

# List installed
choco list --local-only

# Uninstall
choco uninstall package-name -y
```

### WSL Setup

If you enable WSL:

```powershell
# In packages.ps1
$INSTALL_WSL = $true

# After bootstrap completes and you restart:
wsl --install -d Ubuntu

# Or other distros:
wsl --list --online
wsl --install -d Debian
```

### Common Issues

**Package not found:**

- Verify package ID is correct
- Try different case (some are case-sensitive)
- Check if available via alternative package manager

**Installation fails:**

- Run PowerShell as Administrator
- Check internet connection
- Try installing package individually

**Chocolatey install slow:**

- First install downloads .NET dependencies
- Subsequent installs are faster
