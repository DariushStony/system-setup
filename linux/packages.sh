#!/usr/bin/env bash
# Linux Package Lists
# This file defines all packages to install on Linux

########################################
# BASE PACKAGES (All Distributions)
########################################

BASE_PACKAGES=(
  "curl"
  "wget"
  "git"
  "zsh"
  "tmux"
  "htop"
  "tree"
)

########################################
# DEVELOPMENT TOOLS
########################################

DEV_PACKAGES=(
  "build-essential"    # Ubuntu/Debian
  "gcc"                # Fedora/Arch (will be adapted per distro)
  "make"
  "golang-go"          # or "go" for some distros
  "python3"
  "python3-pip"
)

########################################
# CLI TOOLS
########################################

CLI_TOOLS=(
  "httpie"
  "neovim"
  "ripgrep"
  "fd-find"            # or "fd" for some distros
  "fzf"
  "jq"
  "bat"
)

########################################
# DOCKER
########################################

INSTALL_DOCKER=true

########################################
# GUI APPLICATIONS
########################################

GUI_APPS=(
  # "code"             # VS Code (installed separately via official repo)
  # "google-chrome"    # Chrome (installed separately)
  # "firefox"          # Usually pre-installed
)

INSTALL_VSCODE=true
INSTALL_CHROME=false  # Set to true if you want Chrome

########################################
# ZSH PLUGINS
########################################

ZSH_PLUGINS=(
  "zsh-autosuggestions"
  "zsh-syntax-highlighting"
)

INSTALL_OH_MY_ZSH=true
CHANGE_SHELL_TO_ZSH=true

########################################
# NODE.JS
########################################

INSTALL_FNM=true
INSTALL_NODE_LTS=true

########################################
# OPTIONAL PACKAGES (commented out)
########################################

# Uncomment to install:
# OPTIONAL_PACKAGES=(
#   "docker-compose"
#   "postgresql"
#   "redis"
#   "nginx"
# )

