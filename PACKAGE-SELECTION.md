# 📦 Package Selection Guide

Complete control over what gets installed!

---

## 🎯 Quick Start

### Method 1: Interactive Menu (Easiest)

```bash
make select
```

You'll see a menu:
```
╔════════════════════════════════════════╗
║     Package Selection Tool             ║
╚════════════════════════════════════════╝

1) Interactive selection (choose each category)
2) Preset: Minimal (essentials only)
3) Preset: Developer (recommended)
4) Preset: Full (everything)
5) Show current selection
6) Edit config file manually
7) Exit

Choose an option [1-7]: 
```

### Method 2: Quick Presets

```bash
./select-packages.sh --minimal      # Essentials only
./select-packages.sh --developer    # Recommended
./select-packages.sh --full         # Everything
```

### Method 3: Manual Edit

```bash
vim .package-categories
# Edit true/false values
```

---

## 📋 Package Categories

### Essential Tools ⭐ (Recommended: Yes)
**What:** git, curl, wget, tree, htop
**Why:** Core tools needed for everything
**Size:** ~50 MB

### Programming Languages ⭐ (Recommended: Yes)
**What:** Node.js (fnm), Go, Python
**Why:** Runtime environments for development
**Size:** ~500 MB

### Development Tools (Recommended: Yes)
**What:** Docker, Postman, Proxyman, HTTPie
**Why:** Essential for API and container development
**Size:** ~2 GB (Docker is large)

### Browsers (Recommended: Partial)
**What:** Chrome, Firefox, Arc, Edge
**Why:** Testing and browsing
**Size:** ~500 MB per browser

### Editors & IDEs ⭐ (Recommended: Yes)
**What:** VS Code, Cursor, WebStorm
**Why:** Code editors you'll use daily
**Size:** ~500 MB per editor

### Communication (Recommended: Depends on workflow)
**What:** Slack, Microsoft Teams
**Why:** Team communication
**Size:** ~300 MB per app

### Productivity (Recommended: Optional)
**What:** Figma, Obsidian, Excalidraw
**Why:** Design and note-taking
**Size:** ~200 MB per app

### Media (Recommended: Optional)
**What:** Spotify, VLC
**Why:** Music and video playback
**Size:** ~300 MB

### Window Managers ⭐ (Recommended: Yes on macOS)
**What:** Rectangle, Raycast, AltTab
**Why:** Essential for productivity on macOS
**Size:** ~50 MB

### Developer Fonts (Recommended: Yes)
**What:** JetBrains Mono, Fira Code, Cascadia Code
**Why:** Better code readability
**Size:** ~10 MB

### Zsh Plugins ⭐ (Recommended: Yes)
**What:** Autosuggestions, syntax highlighting, pure theme
**Why:** Better terminal experience
**Size:** ~5 MB

### Optional/Fun Tools (Recommended: No)
**What:** figlet, lolcat, toilet, qrencode
**Why:** Fun CLI tools for ASCII art
**Size:** ~10 MB

---

## 🎨 Presets Explained

### Minimal (⚡ Fast - 5 min)
- ✅ Essential tools
- ✅ Programming languages
- ✅ Editors & IDEs
- ✅ Zsh plugins
- ❌ Everything else

**Perfect for:** Lightweight setup, servers, CI/CD

**Total size:** ~1 GB

### Developer (⭐ Recommended - 15 min)
- ✅ Everything from Minimal
- ✅ Development tools
- ✅ Browsers
- ✅ Communication
- ✅ Productivity
- ✅ Window managers
- ✅ Fonts
- ❌ Media, Optional tools

**Perfect for:** Most developers

**Total size:** ~5 GB

### Full (📦 Everything - 25 min)
- ✅ Everything enabled

**Perfect for:** Power users, want it all

**Total size:** ~6 GB

---

## 💡 Usage Examples

### Example 1: Choose Specific Categories

```bash
# Run interactive selection
make select

# Choose option 1 (Interactive selection)
# Answer prompts:
Install Essential tools? [Y/n] y
Install Programming languages? [Y/n] y
Install Development tools? [Y/n] y
Install Browsers? [Y/n] n        ← Skip browsers
Install Editors & IDEs? [Y/n] y
...

# Then install
make install
```

### Example 2: Apply Preset, Then Customize

```bash
# Start with developer preset
./select-packages.sh --developer

# View it
./select-packages.sh --show

# Customize if needed
vim .package-categories

# Install
make install
```

### Example 3: Preview Before Installing

```bash
# Apply minimal preset
./select-packages.sh --minimal

# Preview what will be installed
make dry-run

# If looks good, install
make install
```

---

## 📝 Configuration File

Location: `.package-categories`

```bash
# Example .package-categories
INSTALL_ESSENTIALS=true
INSTALL_LANGUAGES=true
INSTALL_DEV_TOOLS=true
INSTALL_BROWSERS=false        ← Disabled
INSTALL_EDITORS=true
INSTALL_COMMUNICATION=false   ← Disabled
INSTALL_PRODUCTIVITY=false    ← Disabled
INSTALL_MEDIA=false           ← Disabled
INSTALL_WINDOW_MANAGERS=true
INSTALL_FONTS=true
INSTALL_ZSH_PLUGINS=true
INSTALL_OPTIONAL=false
```

**Edit manually:**
```bash
vim .package-categories
# Change true/false values
make install
```

---

## 🔄 Changing Selection

### After Initial Install

```bash
# Change your selection
make select

# View changes
./select-packages.sh --show

# Install newly selected packages
make install
```

### Reset to Defaults

```bash
make reset-selection    # Remove config
make select             # Choose again
```

---

## 🎯 Platform-Specific Behavior

### macOS
All categories available via Homebrew.

### Linux
Some GUI apps may not be available (depends on distribution).

### Windows
Uses Winget + Chocolatey packages.

---

## 📊 Size Estimates

| Category | macOS | Linux | Windows |
|----------|-------|-------|---------|
| Essential | 50 MB | 30 MB | 40 MB |
| Languages | 500 MB | 400 MB | 500 MB |
| Dev Tools | 2 GB | 1.5 GB | 2 GB |
| Browsers | 2 GB | 1 GB | 1.5 GB |
| Editors | 1 GB | 500 MB | 800 MB |
| Communication | 600 MB | - | 500 MB |
| Productivity | 400 MB | 200 MB | 300 MB |
| Media | 600 MB | 200 MB | 400 MB |
| Window Mgr | 50 MB | - | - |
| Fonts | 10 MB | 10 MB | 10 MB |
| Zsh Plugins | 5 MB | 5 MB | - |
| Optional | 10 MB | 10 MB | 10 MB |

---

## 💡 Tips

### 1. Start Minimal, Add Later
```bash
# Install essentials first
./select-packages.sh --minimal
make install

# Add more later
make select    # Enable more categories
make install   # Install newly selected
```

### 2. Different Setups for Different Machines

**Work laptop:**
```bash
./select-packages.sh --developer
# Enable: Communication, Productivity
make install
```

**Personal laptop:**
```bash
./select-packages.sh --full
# Everything!
make install
```

**Server:**
```bash
./select-packages.sh --minimal
# CLI tools only
make install
```

### 3. Save Disk Space

Disable what you don't need:
```bash
make select
# Disable: Media, Optional, Browsers (if you only use one)
make install
```

---

## 🆘 Troubleshooting

### Selection Not Working

```bash
# Reset and try again
rm .package-categories
make select
```

### Want to Change After Install

```bash
# Just select again and re-run
make select
make install
# Only newly selected packages will install
```

### Check What's Selected

```bash
./select-packages.sh --show
# Or
cat .package-categories
```

---

## 🎉 Benefits

✅ **Control** - Choose exactly what you want
✅ **Flexibility** - Different presets for different needs
✅ **Transparency** - See what will be installed
✅ **Efficiency** - Don't install what you won't use
✅ **Easy** - Interactive or preset-based

---

**Now you have complete control over your setup!** 🎮

Users can install only what they need, saving time and disk space.

