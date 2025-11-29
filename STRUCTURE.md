# 📁 Project Structure

Simple, clean directory organization for one-time development environment setup.

---

## 📂 Directory Tree

```
system-setup/
├── lib/                    # Core functionality scripts
│   ├── bootstrap.sh       # Universal bootstrap launcher
│   ├── select-packages.sh # Package selection tool
│   └── update.sh          # Update script
│
├── platforms/              # Platform-specific implementations
│   ├── macos/
│   │   ├── bootstrap.sh   # macOS setup script
│   │   ├── Brewfile       # Homebrew packages
│   │   └── README.md      # macOS-specific docs
│   ├── linux/
│   │   ├── bootstrap.sh   # Linux setup script
│   │   ├── packages.sh    # Linux packages
│   │   └── README.md      # Linux-specific docs
│   └── windows/
│       ├── bootstrap.ps1  # Windows setup script
│       ├── packages.ps1   # Windows packages
│       └── README.md      # Windows-specific docs
│
├── docs/                   # Documentation
│   ├── USAGE.md           # Usage instructions
│   └── PACKAGE-SELECTION.md # Package selection guide
│
├── README.md              # Main documentation
├── LICENSE                # MIT License
├── Makefile               # Simple commands (make install, etc.)
├── install.sh             # One-line remote installer
├── STRUCTURE.md           # This file
└── .package-categories    # Package selection config (generated)
```

---

## 📖 Directory Descriptions

### `lib/` - Core Scripts

Core functionality and helper scripts.

- **`bootstrap.sh`**: Universal launcher that detects OS and calls platform scripts
- **`select-packages.sh`**: Interactive package selection tool
- **`update.sh`**: Updates packages and dependencies

### `platforms/` - Platform-Specific Code

Separated by operating system for clean organization.

- **`macos/`**: Homebrew-based setup for macOS
- **`linux/`**: apt/dnf/pacman-based setup for Linux distributions
- **`windows/`**: Winget/Chocolatey-based setup for Windows

### `docs/` - Documentation

Documentation files organized in one place.

- **`USAGE.md`**: Detailed usage instructions
- **`PACKAGE-SELECTION.md`**: Package selection guide

### Root Files

Essential files in the root directory:

- **`README.md`**: Main project documentation
- **`LICENSE`**: MIT License
- **`Makefile`**: Task automation (`make install`, etc.)
- **`install.sh`**: One-line remote installer
- **`.package-categories`**: Generated package configuration

---

## 🎯 Design Principles

### 1. Simplicity

- Only essential files
- Clear directory names
- Easy to understand

### 2. One-Time Focus

- No CLI tool installation
- No completion scripts
- Direct script execution

### 3. Clean Root Directory

Only essential files in root:

- README, LICENSE, Makefile, install.sh
- No clutter, easy to navigate

### 4. Platform Separation

- Each platform in its own directory
- No mixing of macOS and Linux code
- Easy to customize per platform

---

## 🔧 Path References

### In Scripts

All scripts use relative paths from SCRIPT_DIR:

```bash
# Get project root
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Reference other scripts
"$SCRIPT_DIR/lib/bootstrap.sh"
"$SCRIPT_DIR/platforms/macos/bootstrap.sh"
```

---

## 📦 Configuration Files

### Generated Files

Stay in root for easy access:

- `.package-categories` - Package selection (root)
- `~/.system-setup-config` - User config (home directory)

### Platform-Specific Package Lists

In platform directories:

- `platforms/macos/Brewfile` - Homebrew packages
- `platforms/linux/packages.sh` - Linux packages
- `platforms/windows/packages.ps1` - Windows packages

---

## 🚀 Benefits of This Structure

✅ **Simple** - Only what's needed, nothing extra
✅ **Clean** - Root directory is organized
✅ **Professional** - Follows standard conventions
✅ **Maintainable** - Clear where everything belongs
✅ **User-Friendly** - Easy to use and understand
✅ **Platform-Agnostic** - Supports macOS, Linux, Windows

---

## 💡 Adding New Features

### Adding a New Platform

```bash
mkdir -p platforms/freebsd
# Add bootstrap script and packages
```

### Adding a New Script

```bash
# Add to lib/ for core functionality
lib/backup.sh
```

### Adding Documentation

```bash
# Add to docs/
docs/TROUBLESHOOTING.md
```

---

## 📊 File Count

| Directory | Files | Purpose |
|-----------|-------|---------|
| `lib/` | 3 | Core scripts |
| `platforms/` | 9 | Platform-specific code |
| `docs/` | 2 | Documentation |
| **Root** | 5 | Essential files only |

**Total: ~20 organized files**

---

## 🎓 Best Practices

1. **Keep root clean** - Only essential files
2. **Use relative paths** - Portable across systems
3. **Separate platforms** - Don't mix platform code
4. **Document structure** - This file!
5. **Follow conventions** - Use standard directory names

---

**Simple structure for one-time setup!** 🎉
