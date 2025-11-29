# ⚡ dev-setup Quick Reference Card

One-page reference for all `dev-setup` commands.

---

## 📥 Installation

```bash
git clone <repo-url> ~/dev-setup
cd ~/dev-setup
./install-cli.sh
```

---

## 🎯 Essential Commands

```bash
dev-setup select         # Choose packages
dev-setup install        # Install
dev-setup update         # Update packages
dev-setup list           # Show packages
dev-setup doctor         # Check system
dev-setup help           # Show help
```

---

## 📦 Installation

```bash
# Interactive (recommended)
dev-setup select         # Choose what to install
dev-setup install        # Install selected

# Quick presets
dev-setup select --minimal
dev-setup select --developer
dev-setup select --full

# Install modes
dev-setup install                # Standard
dev-setup install --minimal      # Minimal
dev-setup install --full         # Full
dev-setup install --dry-run      # Preview only
dev-setup install --use-config   # Skip prompts
```

---

## 🔄 Maintenance

```bash
dev-setup update         # Update all packages
dev-setup check          # Check status
dev-setup clean          # Clean temp files
dev-setup doctor         # System check
```

---

## ⚙️ Configuration

```bash
dev-setup config show    # View config
dev-setup config edit    # Edit config
dev-setup config reset   # Reset all
```

---

## 📋 Information

```bash
dev-setup list           # List packages & selection
dev-setup version        # Show version
dev-setup help           # Show help
```

---

## 🎮 Common Workflows

### New Machine Setup
```bash
dev-setup select         # 1. Choose packages
dev-setup install        # 2. Install
```

### Quick Minimal Setup
```bash
dev-setup select --minimal && dev-setup install
```

### Preview Before Install
```bash
dev-setup select --developer
dev-setup install --dry-run
dev-setup install
```

### Regular Updates
```bash
dev-setup update
```

---

## 📦 Package Categories

- Essential tools (git, curl, wget)
- Programming languages (Node, Go, Python)
- Development tools (Docker, Postman)
- Browsers (Chrome, Firefox, Arc)
- Editors & IDEs (VS Code, Cursor)
- Communication (Slack, Teams)
- Productivity (Figma, Obsidian)
- Media (Spotify, VLC)
- Window managers (Rectangle, Raycast)
- Fonts (JetBrains Mono, Fira Code)
- Zsh plugins
- Optional/Fun tools

---

## 🎚️ Presets

| Preset | Time | Size | Includes |
|--------|------|------|----------|
| **Minimal** | ~5 min | ~1 GB | Essentials, Languages, Editors |
| **Developer** | ~15 min | ~5 GB | + Dev tools, Browsers, Fonts |
| **Full** | ~25 min | ~6 GB | Everything |

---

## 💡 Tips

```bash
# Show current selection
dev-setup list

# Check system health
dev-setup doctor

# Reset and start over
dev-setup config reset

# Quick status check
dev-setup doctor && dev-setup list

# Use saved config
dev-setup install --use-config
```

---

## 🔧 Troubleshooting

```bash
# Command not found?
which dev-setup
./install-cli.sh

# Check system
dev-setup doctor

# Reset everything
dev-setup config reset
rm ~/.dev-setup-config

# Reinstall CLI
cd ~/dev-setup
./install-cli.sh
```

---

## 📂 Configuration Files

```bash
~/.dev-setup-config         # Global settings
~/dev-setup/.package-categories    # Package selection
```

---

## 🆘 Help

```bash
dev-setup help              # General help
dev-setup install --help    # Command-specific help
```

**Full docs:** [CLI-GUIDE.md](CLI-GUIDE.md)

---

## 🔗 Useful Aliases

Add to `.zshrc` or `.bashrc`:

```bash
alias ds='dev-setup'
alias dsi='dev-setup install'
alias dsu='dev-setup update'
alias dsl='dev-setup list'
alias dsc='dev-setup check'
alias dsd='dev-setup doctor'
```

---

## ⌨️ Shell Completion

**Bash:**
```bash
source ~/dev-setup/completions/dev-setup.bash
```

**Zsh:**
```bash
# Add to ~/.zshrc
fpath=(~/dev-setup/completions $fpath)
autoload -U compinit && compinit
```

---

**Print this page for quick reference!** 📄

