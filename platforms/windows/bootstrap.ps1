# Windows Bootstrap Script
# Run as Administrator: Set-ExecutionPolicy Bypass -Scope Process -Force; .\bootstrap-windows.ps1

########################################
# COLLECT USER INPUT
########################################

Write-Host ""
Write-Host "╔════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║   Windows Bootstrap Configuration      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Git Name
$GIT_NAME = Read-Host "Enter your full name for Git"
if ([string]::IsNullOrWhiteSpace($GIT_NAME)) {
    $GIT_NAME = "Your Name"
}

# Git Email
$GIT_EMAIL = Read-Host "Enter your email for Git"
if ([string]::IsNullOrWhiteSpace($GIT_EMAIL)) {
    $GIT_EMAIL = "your.email@example.com"
}

# Dotfiles Repository (optional - for cloning)
$DOTFILES_REPO_URL = Read-Host "Enter your dotfiles repository URL (or press Enter to skip)"

# Dotfiles Directory (can be local folder or clone destination)
$defaultDir = "$env:USERPROFILE\.dotfiles"
$DOTFILES_DIR_INPUT = Read-Host "Enter dotfiles directory [default: $defaultDir]"
if ([string]::IsNullOrWhiteSpace($DOTFILES_DIR_INPUT)) {
    $DOTFILES_DIR = $defaultDir
} else {
    $DOTFILES_DIR = $DOTFILES_DIR_INPUT
}

Write-Host ""
Write-Log "Configuration:"
Write-Host "  Git Name: $GIT_NAME" -ForegroundColor Gray
Write-Host "  Git Email: $GIT_EMAIL" -ForegroundColor Gray
if (-not [string]::IsNullOrWhiteSpace($DOTFILES_REPO_URL)) {
    Write-Host "  Dotfiles Repo: $DOTFILES_REPO_URL (will clone)" -ForegroundColor Gray
    Write-Host "  Dotfiles Dir: $DOTFILES_DIR" -ForegroundColor Gray
} elseif (Test-Path $DOTFILES_DIR) {
    Write-Host "  Dotfiles Dir: $DOTFILES_DIR (local)" -ForegroundColor Gray
} else {
    Write-Host "  Dotfiles: Will check $DOTFILES_DIR" -ForegroundColor Gray
}
Write-Host ""

########################################
# LOAD PACKAGE LISTS
########################################

$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$PACKAGES_FILE = Join-Path $SCRIPT_DIR "packages.ps1"

if (Test-Path $PACKAGES_FILE) {
    . $PACKAGES_FILE
    Write-Log "Loaded package lists from packages.ps1"
} else {
    Write-Warning-Custom "Package file not found at $PACKAGES_FILE. Using defaults."
}

########################################
# HELPERS
########################################

function Write-Log {
    param([string]$Message)
    Write-Host "`n[INFO] $Message" -ForegroundColor Cyan
}

function Write-Warning-Custom {
    param([string]$Message)
    Write-Host "`n[WARN] $Message" -ForegroundColor Yellow
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "`n[ERROR] $Message" -ForegroundColor Red
    exit 1
}

########################################
# 0. Check if Running as Administrator
########################################

function Test-Administrator {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Error-Custom "This script must be run as Administrator. Right-click PowerShell and select 'Run as Administrator'."
}

########################################
# 1. Install Winget (if not already installed)
########################################

function Install-Winget {
    Write-Log "Checking for winget..."
    
    if (Get-Command winget -ErrorAction SilentlyContinue) {
        Write-Log "winget already installed."
    } else {
        Write-Log "Installing winget..."
        # Winget comes with App Installer from Microsoft Store
        # Or install manually from GitHub
        Write-Warning-Custom "Please install App Installer from Microsoft Store to get winget."
        Write-Warning-Custom "URL: https://www.microsoft.com/p/app-installer/9nblggh4nns1"
        pause
    }
}

########################################
# 2. Install Chocolatey (Alternative Package Manager)
########################################

function Install-Chocolatey {
    Write-Log "Checking for Chocolatey..."
    
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Log "Chocolatey already installed."
    } else {
        Write-Log "Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force
        [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
        
        # Refresh environment variables
        $env:ChocolateyInstall = Convert-Path "$((Get-Command choco).Path)\..\.."
        Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
        refreshenv
    }
}

########################################
# 3. Install Git
########################################

function Install-Git {
    Write-Log "Installing Git..."
    
    if (Get-Command git -ErrorAction SilentlyContinue) {
        Write-Log "Git already installed."
    } else {
        winget install --id Git.Git -e --source winget --silent --accept-package-agreements --accept-source-agreements
        # Or using chocolatey: choco install git -y
        
        # Refresh PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }
}

########################################
# 4. Install Development Tools
########################################

function Install-DevTools {
    Write-Log "Installing development tools via Winget..."
    
    foreach ($package in $WINGET_PACKAGES) {
        Write-Log "Installing $($package.Name)..."
        winget install --id $($package.Id) -e --source winget --silent --accept-package-agreements --accept-source-agreements
    }
}

########################################
# 5. Install CLI Tools
########################################

function Install-CLITools {
    Write-Log "Installing CLI tools via Chocolatey..."
    
    foreach ($package in $CHOCOLATEY_PACKAGES) {
        Write-Log "Installing $package..."
        choco install $package -y
    }
}

########################################
# 6. Install fnm (Fast Node Manager)
########################################

function Install-Fnm {
    Write-Log "Installing fnm (Fast Node Manager)..."
    
    if (Get-Command fnm -ErrorAction SilentlyContinue) {
        Write-Log "fnm already installed."
    } else {
        # Install via winget
        winget install Schniz.fnm --silent --accept-package-agreements --accept-source-agreements
        
        # Or using chocolatey
        # choco install fnm -y
        
        # Refresh PATH
        $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    }
}

########################################
# 7. Setup fnm and Install Node.js
########################################

function Setup-Fnm-NodeJS {
    Write-Log "Setting up fnm and installing Node.js..."
    
    if (-not (Get-Command fnm -ErrorAction SilentlyContinue)) {
        Write-Warning-Custom "fnm not found. Skipping Node.js installation."
        return
    }
    
    # Install latest LTS
    fnm install --lts
    fnm default lts-latest
    
    Write-Log "Node.js installed via fnm successfully!"
}

########################################
# 8. Install GUI Applications
########################################

function Install-GUIApps {
    Write-Log "GUI applications already included in WINGET_PACKAGES."
    # All GUI apps are now in the WINGET_PACKAGES array in packages.ps1
}

########################################
# 9. Install Fonts
########################################

function Install-Fonts {
    Write-Log "Fonts already included in CHOCOLATEY_PACKAGES."
    # Fonts are now in the CHOCOLATEY_PACKAGES array in packages.ps1
}

########################################
# 10. Setup Dotfiles
########################################

function Setup-Dotfiles {
    # Clone from repo if URL provided
    if (-not [string]::IsNullOrWhiteSpace($DOTFILES_REPO_URL)) {
        if (Test-Path "$DOTFILES_DIR\.git") {
            Write-Log "Dotfiles repo already exists at $DOTFILES_DIR. Pulling latest..."
            git -C $DOTFILES_DIR pull --ff-only
        } else {
            Write-Log "Cloning dotfiles repo into $DOTFILES_DIR..."
            git clone $DOTFILES_REPO_URL $DOTFILES_DIR
            Write-Host "✓ Dotfiles cloned to: $DOTFILES_DIR" -ForegroundColor Green
        }
    }
    
    # Check if dotfiles directory exists (either cloned or local)
    if (-not (Test-Path $DOTFILES_DIR)) {
        Write-Log "Dotfiles directory not found at $DOTFILES_DIR. Skipping dotfiles setup."
        Write-Log "You can manually create it later and re-run this script."
        return
    }
    
    # Link dotfiles (PowerShell profile)
    if (Test-Path "$DOTFILES_DIR\windows\Microsoft.PowerShell_profile.ps1") {
        $profilePath = $PROFILE.CurrentUserAllHosts
        $profileDir = Split-Path -Parent $profilePath
        
        if (-not (Test-Path $profileDir)) {
            New-Item -ItemType Directory -Force -Path $profileDir
        }
        
        New-Item -ItemType SymbolicLink -Path $profilePath -Target "$DOTFILES_DIR\windows\Microsoft.PowerShell_profile.ps1" -Force
        Write-Log "PowerShell profile linked."
    }
    
    # Git config
    if (Test-Path "$DOTFILES_DIR\git\.gitconfig") {
        Copy-Item "$DOTFILES_DIR\git\.gitconfig" "$env:USERPROFILE\.gitconfig" -Force
        Write-Log "Git config linked."
    }
    
    # VS Code settings (Windows)
    if (Test-Path "$DOTFILES_DIR\vscode\settings.json") {
        $vscodeDir = "$env:APPDATA\Code\User"
        if (-not (Test-Path $vscodeDir)) {
            New-Item -ItemType Directory -Force -Path $vscodeDir
        }
        Copy-Item "$DOTFILES_DIR\vscode\settings.json" "$vscodeDir\settings.json" -Force
        Write-Log "VS Code settings linked."
    }
}

########################################
# 11. Configure Git
########################################

function Configure-Git {
    Write-Log "Configuring Git..."
    
    git config --global user.name $GIT_NAME
    git config --global user.email $GIT_EMAIL
    git config --global pull.rebase false
    git config --global init.defaultBranch main
    git config --global core.autocrlf true
}

########################################
# 12. Setup PowerShell Profile
########################################

function Setup-PowerShellProfile {
    Write-Log "Setting up PowerShell profile..."
    
    $profilePath = $PROFILE.CurrentUserAllHosts
    $profileDir = Split-Path -Parent $profilePath
    
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Force -Path $profileDir
    }
    
    if (-not (Test-Path $profilePath)) {
        # Create basic profile with fnm
        $profileContent = @"
# PowerShell Profile

# fnm (Fast Node Manager)
fnm env --use-on-cd | Out-String | Invoke-Expression

# Aliases
Set-Alias -Name vim -Value nvim
Set-Alias -Name ll -Value Get-ChildItem

# Custom prompt (optional)
function prompt {
    Write-Host "[" -NoNewline
    Write-Host (Get-Location) -ForegroundColor Cyan -NoNewline
    Write-Host "]"
    return "> "
}
"@
        Set-Content -Path $profilePath -Value $profileContent
        Write-Log "PowerShell profile created."
    }
}

########################################
# 13. Install Windows Subsystem for Linux (Optional)
########################################

function Install-WSL {
    Write-Log "Installing WSL (Windows Subsystem for Linux)..."
    
    wsl --install -d Ubuntu
    Write-Log "WSL installed. Please restart your computer if prompted."
}

########################################
# MAIN
########################################

function Main {
    Write-Log "🚀 Starting Windows bootstrap..."
    
    Install-Winget
    Install-Chocolatey
    Install-Git
    Install-DevTools
    Install-CLITools
    Install-Fnm
    Setup-Fnm-NodeJS
    Configure-Git
    Setup-Dotfiles
    Setup-PowerShellProfile
    
    # Optional: Install WSL (check packages.ps1)
    if ($INSTALL_WSL) {
        Install-WSL
    }
    
    Write-Log "✅ All done! Please restart your computer for all changes to take effect."
    Write-Log "   Then run 'fnm install --lts' to install Node.js"
}

# Run main function
Main

