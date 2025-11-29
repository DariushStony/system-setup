# 📁 Project Structure

Clean, professional directory organization for the dev-setup project.

---

## 📂 Directory Tree

```
dev-setup/
├── bin/                    # Executable CLI tool
│   └── dev-setup          # Main CLI executable
│
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
├── completions/            # Shell auto-completions
│   ├── dev-setup.bash     # Bash completion
│   └── dev-setup.zsh      # Zsh completion
│
├── docs/                   # Documentation
│   ├── CLI-GUIDE.md       # Complete CLI guide
│   ├── USAGE.md           # Usage instructions
│   ├── PACKAGE-SELECTION.md # Package selection guide
│   └── QUICK-REFERENCE.md # Quick reference card
│
├── scripts/                # Installation scripts
│   └── install-cli.sh     # CLI tool installer
│
├── README.md              # Main documentation
├── LICENSE                # MIT License
├── Makefile               # Build & task automation
├── install.sh             # One-line remote installer
└── .package-categories    # Package selection config (generated)
```

---

## 📖 Directory Descriptions

### `bin/` - Executables
Contains the main CLI executable that users interact with.
- **`dev-setup`**: The main CLI tool symlinked to `/usr/local/bin`

### `lib/` - Core Libraries
Core functionality and helper scripts used by the CLI tool.
- **`bootstrap.sh`**: Universal launcher that detects OS and calls platform scripts
- **`select-packages.sh`**: Interactive package selection tool
- **`update.sh`**: Updates packages and dependencies

### `platforms/` - Platform-Specific Code
Separated by operating system for clean organization.
- **`macos/`**: Homebrew-based setup for macOS
- **`linux/`**: apt/dnf/pacman-based setup for Linux distributions
- **`windows/`**: Winget/Chocolatey-based setup for Windows

### `completions/` - Shell Completions
Auto-completion files for better CLI experience.
- **`dev-setup.bash`**: Bash shell completion
- **`dev-setup.zsh`**: Zsh shell completion

### `docs/` - Documentation
All documentation files organized in one place.
- **`CLI-GUIDE.md`**: Complete CLI tool documentation
- **`USAGE.md`**: Detailed usage instructions
- **`PACKAGE-SELECTION.md`**: Package selection guide
- **`QUICK-REFERENCE.md`**: Quick reference card

### `scripts/` - Utility Scripts
Installation and setup scripts.
- **`install-cli.sh`**: Installs the CLI tool globally

### Root Files
Essential files in the root directory:
- **`README.md`**: Main project documentation
- **`LICENSE`**: MIT License
- **`Makefile`**: Task automation (`make install`, etc.)
- **`install.sh`**: One-line remote installer
- **`.package-categories`**: Generated package configuration

---

## 🎯 Design Principles

### 1. Separation of Concerns
- **bin/**: User-facing interface
- **lib/**: Core logic
- **platforms/**: Platform-specific implementations
- **docs/**: Documentation

### 2. Clean Root Directory
Only essential files in root:
- README, LICENSE, Makefile
- No clutter, easy to navigate

### 3. Self-Documenting Structure
Directory names clearly indicate contents:
- `bin/` for executables
- `lib/` for libraries
- `platforms/` for platform code
- `docs/` for documentation

### 4. Standard Conventions
Follows common project structures:
- Similar to projects like: Homebrew, rbenv, nvm
- Familiar to developers
- Easy to understand

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

### In CLI Tool (`bin/dev-setup`)

```bash
BIN_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_DIR="$(cd "$BIN_DIR/.." && pwd)"
LIB_DIR="$SCRIPT_DIR/lib"

# Use these to reference files
"$LIB_DIR/bootstrap.sh"
"$SCRIPT_DIR/platforms/macos/bootstrap.sh"
```

---

## 📦 Package Files Location

### Configuration Files

Generated files stay in root for easy access:
- `.package-categories` - Package selection (root)
- `~/.dev-setup-config` - User config (home directory)

### Platform-Specific Package Lists

In platform directories:
- `platforms/macos/Brewfile` - Homebrew packages
- `platforms/linux/packages.sh` - Linux packages
- `platforms/windows/packages.ps1` - Windows packages

---

## 🚀 Benefits of This Structure

✅ **Clean** - Root directory is not cluttered
✅ **Professional** - Follows industry standards
✅ **Scalable** - Easy to add new platforms or scripts
✅ **Maintainable** - Clear where everything belongs
✅ **User-Friendly** - Users only interact with simple commands
✅ **Developer-Friendly** - Easy to contribute and understand

---

## 🔄 Migration from Old Structure

### Old Structure (Flat)
```
dev-setup/
├── dev-setup
├── bootstrap.sh
├── select-packages.sh
├── update.sh
├── install-cli.sh
├── macos/
├── linux/
├── windows/
├── completions/
├── CLI-GUIDE.md
├── USAGE.md
└── ...
```

### New Structure (Organized)
```
dev-setup/
├── bin/dev-setup
├── lib/bootstrap.sh, select-packages.sh, update.sh
├── platforms/macos, linux, windows
├── completions/
├── docs/CLI-GUIDE.md, USAGE.md
├── scripts/install-cli.sh
└── README.md, LICENSE, Makefile
```

**Changes:**
- Moved `dev-setup` → `bin/dev-setup`
- Moved scripts → `lib/`
- Renamed `macos/` → `platforms/macos/`
- Moved docs → `docs/`
- Moved `install-cli.sh` → `scripts/`

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

# Or scripts/ for utilities
scripts/uninstall.sh
```

### Adding Documentation
```bash
# Add to docs/
docs/TROUBLESHOOTING.md
```

---

## 📊 File Count by Directory

| Directory | Files | Purpose |
|-----------|-------|---------|
| `bin/` | 1 | CLI executable |
| `lib/` | 3 | Core scripts |
| `platforms/` | 9 | Platform-specific code |
| `completions/` | 2 | Shell completions |
| `docs/` | 4 | Documentation |
| `scripts/` | 1 | Utilities |
| **Root** | 4 | Essential files only |

**Total: 24 organized files**

---

## 🎓 Best Practices

1. **Keep root clean** - Only essential files
2. **Use relative paths** - Portable across systems
3. **Separate platforms** - Don't mix macOS and Linux code
4. **Document structure** - This file!
5. **Follow conventions** - Use standard directory names

---

**This structure makes the project professional and maintainable!** 🎉

