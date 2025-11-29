# Windows Package Lists
# This file defines all packages to install on Windows

########################################
# WINGET PACKAGES
########################################

$WINGET_PACKAGES = @(
    # Development Tools
    @{Id="Microsoft.VisualStudioCode"; Name="VS Code"},
    @{Id="Microsoft.WindowsTerminal"; Name="Windows Terminal"},
    @{Id="Docker.DockerDesktop"; Name="Docker Desktop"},
    @{Id="Postman.Postman"; Name="Postman"},
    
    # Programming Languages
    @{Id="OpenJS.NodeJS.LTS"; Name="Node.js LTS"},
    @{Id="GoLang.Go"; Name="Go"},
    @{Id="Python.Python.3.12"; Name="Python 3.12"},
    
    # Browsers
    @{Id="Google.Chrome"; Name="Google Chrome"},
    @{Id="Mozilla.Firefox"; Name="Firefox"},
    @{Id="Microsoft.Edge"; Name="Microsoft Edge"},
    
    # Communication
    @{Id="SlackTechnologies.Slack"; Name="Slack"},
    @{Id="Microsoft.Teams"; Name="Microsoft Teams"},
    
    # Productivity
    @{Id="Figma.Figma"; Name="Figma"},
    @{Id="Obsidian.Obsidian"; Name="Obsidian"},
    
    # Media
    @{Id="Spotify.Spotify"; Name="Spotify"},
    @{Id="VideoLAN.VLC"; Name="VLC"},
    
    # Utilities
    @{Id="Microsoft.PowerToys"; Name="PowerToys"},
    @{Id="Schniz.fnm"; Name="fnm (Fast Node Manager)"}
)

########################################
# CHOCOLATEY PACKAGES
########################################

$CHOCOLATEY_PACKAGES = @(
    # CLI Tools
    "wget",
    "curl",
    "jq",
    "httpie",
    "ripgrep",
    "fd",
    "fzf",
    "bat",
    "neovim",
    
    # Fonts
    "jetbrainsmono",
    "firacode",
    "cascadiacode"
)

########################################
# OPTIONAL PACKAGES (Commented out)
########################################

# Uncomment to install:
# $OPTIONAL_WINGET = @(
#     @{Id="Git.Git"; Name="Git"},
#     @{Id="GitHub.GitHubDesktop"; Name="GitHub Desktop"},
#     @{Id="JetBrains.WebStorm"; Name="WebStorm"}
# )

# $OPTIONAL_CHOCO = @(
#     "docker-compose",
#     "make",
#     "postgresql"
# )

########################################
# CONFIGURATION
########################################

$INSTALL_WSL = $false          # Set to $true to install WSL
$INSTALL_DOCKER = $true
$INSTALL_FNM = $true
$SETUP_POWERSHELL_PROFILE = $true

