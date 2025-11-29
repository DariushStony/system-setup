#!/usr/bin/env bash
set -euo pipefail

########################################
# COLLECT USER INPUT
########################################

echo ""
echo "╔════════════════════════════════════════╗"
echo "║     Linux Bootstrap Configuration      ║"
echo "╚════════════════════════════════════════╝"
echo ""

# Git Name
read -p "Enter your full name for Git: " GIT_NAME
if [ -z "$GIT_NAME" ]; then
  GIT_NAME="Your Name"
fi

# Git Email
read -p "Enter your email for Git: " GIT_EMAIL
if [ -z "$GIT_EMAIL" ]; then
  GIT_EMAIL="your.email@example.com"
fi

# Dotfiles Repository (optional - for cloning)
read -p "Enter your dotfiles repository URL (or press Enter to skip): " DOTFILES_REPO_URL

# Dotfiles Directory (can be local folder or clone destination)
read -p "Enter dotfiles directory [default: ~/.dotfiles]: " DOTFILES_DIR_INPUT
DOTFILES_DIR="${DOTFILES_DIR_INPUT:-$HOME/.dotfiles}"

echo ""
log "Configuration:"
log "  Git Name: $GIT_NAME"
log "  Git Email: $GIT_EMAIL"
if [ -n "$DOTFILES_REPO_URL" ]; then
  log "  Dotfiles Repo: $DOTFILES_REPO_URL (will clone)"
  log "  Dotfiles Dir: $DOTFILES_DIR"
elif [ -n "$DOTFILES_DIR" ] && [ -d "$DOTFILES_DIR" ]; then
  log "  Dotfiles Dir: $DOTFILES_DIR (local)"
else
  log "  Dotfiles: Will check $DOTFILES_DIR"
fi
echo ""

########################################
# LOAD PACKAGE LISTS
########################################

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/packages.sh" ]; then
  source "$SCRIPT_DIR/packages.sh"
else
  warn "Package file not found at $SCRIPT_DIR/packages.sh. Using defaults."
fi

########################################
# HELPERS
########################################

log() {
  printf "\n\033[1;34m[INFO]\033[0m %s\n" "$1"
}

warn() {
  printf "\n\033[1;33m[WARN]\033[0m %s\n" "$1"
}

error() {
  printf "\n\033[1;31m[ERROR]\033[0m %s\n" "$1"
  exit 1
}

########################################
# DETECT LINUX DISTRIBUTION
########################################

detect_distro() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
    log "Detected Linux distribution: $DISTRO"
  else
    error "Cannot detect Linux distribution. /etc/os-release not found."
  fi
}

########################################
# 1. Install Base Dependencies
########################################

install_base_dependencies() {
  log "Installing base dependencies..."
  
  # Join array into space-separated string
  local base_pkgs="${BASE_PACKAGES[@]}"
  
  case "$DISTRO" in
    ubuntu|debian|pop|linuxmint)
      sudo apt update
      sudo apt install -y \
        $base_pkgs \
        build-essential software-properties-common \
        apt-transport-https ca-certificates gnupg lsb-release
      ;;
    
    fedora|rhel|centos)
      sudo dnf update -y
      sudo dnf install -y \
        $base_pkgs \
        gcc gcc-c++ make \
        dnf-plugins-core
      ;;
    
    arch|manjaro)
      sudo pacman -Syu --noconfirm
      sudo pacman -S --noconfirm \
        $base_pkgs \
        base-devel
      ;;
    
    *)
      warn "Unsupported distribution: $DISTRO. Please install dependencies manually."
      ;;
  esac
}

########################################
# 2. Install Development Tools
########################################

install_dev_tools() {
  log "Installing development tools..."
  
  case "$DISTRO" in
    ubuntu|debian|pop|linuxmint)
      # Docker
      curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
      sudo apt update
      sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
      sudo usermod -aG docker $USER
      
      # Python
      sudo apt install -y python3 python3-pip
      
      # Go
      sudo apt install -y golang-go
      ;;
    
    fedora|rhel|centos)
      # Docker
      sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
      sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
      sudo systemctl start docker
      sudo systemctl enable docker
      sudo usermod -aG docker $USER
      
      # Python & Go
      sudo dnf install -y python3 python3-pip golang
      ;;
    
    arch|manjaro)
      # Docker
      sudo pacman -S --noconfirm docker docker-compose
      sudo systemctl start docker
      sudo systemctl enable docker
      sudo usermod -aG docker $USER
      
      # Python & Go
      sudo pacman -S --noconfirm python python-pip go
      ;;
  esac
}

########################################
# 3. Install fnm (Fast Node Manager)
########################################

install_fnm() {
  log "Installing fnm (Fast Node Manager)..."
  
  if command -v fnm >/dev/null 2>&1; then
    log "fnm already installed."
  else
    curl -fsSL https://fnm.vercel.app/install | bash
    
    # Add to PATH for current session
    export PATH="$HOME/.local/share/fnm:$PATH"
    eval "$(fnm env --use-on-cd)"
  fi
}

########################################
# 4. Install Node.js via fnm
########################################

install_nodejs() {
  log "Installing Node.js via fnm..."
  
  if ! command -v fnm >/dev/null 2>&1; then
    warn "fnm not found. Skipping Node.js installation."
    return
  fi
  
  eval "$(fnm env --use-on-cd)"
  fnm install --lts
  fnm default lts-latest
  
  log "Node.js installed successfully!"
}

########################################
# 5. Install Additional Tools
########################################

install_additional_tools() {
  log "Installing additional CLI tools..."
  
  local cli_tools="${CLI_TOOLS[@]}"
  
  case "$DISTRO" in
    ubuntu|debian|pop|linuxmint)
      sudo apt install -y $cli_tools
      ;;
    
    fedora|rhel|centos)
      # Adapt package names for Fedora (fd-find -> fd)
      sudo dnf install -y httpie neovim ripgrep fd-find fzf jq bat
      ;;
    
    arch|manjaro)
      # Adapt package names for Arch (fd-find -> fd)
      sudo pacman -S --noconfirm httpie neovim ripgrep fd fzf jq bat
      ;;
  esac
}

########################################
# 6. Setup Zsh & Oh-My-Zsh
########################################

setup_zsh() {
  log "Setting up Zsh..."
  
  # Install oh-my-zsh
  if [ ! -d "$HOME/.oh-my-zsh" ]; then
    log "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  else
    log "oh-my-zsh already installed."
  fi
  
  # Install zsh plugins
  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  fi
  
  if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  fi
  
  # Change default shell to zsh
  if [ "$SHELL" != "$(which zsh)" ]; then
    log "Changing default shell to zsh..."
    chsh -s $(which zsh)
  fi
}

########################################
# 7. Setup Dotfiles
########################################

setup_dotfiles() {
  # Clone from repo if URL provided
  if [ -n "$DOTFILES_REPO_URL" ]; then
    if [ -d "$DOTFILES_DIR/.git" ]; then
      log "Dotfiles repo already exists at $DOTFILES_DIR. Pulling latest..."
      git -C "$DOTFILES_DIR" pull --ff-only || warn "Could not pull latest dotfiles."
    else
      log "Cloning dotfiles repo into $DOTFILES_DIR..."
      git clone "$DOTFILES_REPO_URL" "$DOTFILES_DIR"
      log "✓ Dotfiles cloned to: $DOTFILES_DIR"
    fi
  fi
  
  # Check if dotfiles directory exists (either cloned or local)
  if [ ! -d "$DOTFILES_DIR" ]; then
    log "Dotfiles directory not found at $DOTFILES_DIR. Skipping dotfiles setup."
    log "You can manually create it later and re-run this script."
    return
  fi
  
  # Link dotfiles
  if [ -d "$DOTFILES_DIR" ]; then
    log "Linking dotfiles..."
    
    # Git
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
      ln -sf "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig"
    fi
    
    # Zsh
    if [ -f "$DOTFILES_DIR/zsh/.zshrc" ]; then
      ln -sf "$DOTFILES_DIR/zsh/.zshrc" "$HOME/.zshrc"
    fi
  else
    warn "Dotfiles directory $DOTFILES_DIR not found. Skipping linking."
  fi
}

########################################
# 8. Configure Git
########################################

configure_git() {
  log "Configuring global git settings..."
  git config --global user.name "$GIT_NAME"
  git config --global user.email "$GIT_EMAIL"
  git config --global pull.rebase false
  git config --global init.defaultBranch main
}

########################################
# 9. Install GUI Applications (Optional)
########################################

install_gui_apps() {
  log "Installing GUI applications..."
  
  case "$DISTRO" in
    ubuntu|debian|pop|linuxmint)
      # VS Code
      wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
      sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
      sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
      rm -f packages.microsoft.gpg
      sudo apt update
      sudo apt install -y code
      
      # Chrome (optional)
      # wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
      # sudo dpkg -i google-chrome-stable_current_amd64.deb
      # rm google-chrome-stable_current_amd64.deb
      ;;
    
    fedora|rhel|centos)
      # VS Code
      sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
      sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
      sudo dnf install -y code
      ;;
    
    arch|manjaro)
      # VS Code (from AUR)
      if command -v yay >/dev/null 2>&1; then
        yay -S --noconfirm visual-studio-code-bin
      else
        warn "yay not found. Please install VS Code manually from AUR."
      fi
      ;;
  esac
}

########################################
# MAIN
########################################

main() {
  log "🚀 Starting Linux bootstrap..."
  
  detect_distro
  install_base_dependencies
  install_dev_tools
  install_fnm
  install_nodejs
  install_additional_tools
  setup_zsh
  setup_dotfiles
  configure_git
  install_gui_apps
  
  log "✅ All done! Please log out and log back in (or restart) for all changes to take effect."
  log "   Run 'source ~/.zshrc' to reload your shell config."
}

main "$@"

