# One-Time Setup Guide

**Don't want to install the CLI tool? No problem!**

This guide shows you how to use this repo for **one-time machine setup** without installing any global commands.

---

## 🎯 Quick Answer

**You DON'T need the dev-setup CLI for one-time setup.**

Just run the scripts and you're done!

---

## 🚀 Method 1: Remote Install (Easiest)

Run this one command:

```bash
curl -fsSL https://raw.githubusercontent.com/username/repo/main/install.sh | bash
```

**What happens:**
1. Downloads and runs install script
2. Installs packages (Homebrew, Node, Go, Docker, etc.)
3. Configures dotfiles (optional)
4. **Does NOT install CLI globally**

**After completion:**
- ✅ All packages installed
- ✅ System configured
- ✅ No extra CLI commands added
- ✅ No repo left on your system

**Time:** ~15 minutes

---

## 🔧 Method 2: Local Install (More Control)

Clone, run, and optionally delete:

```bash
# 1. Clone the repo
git clone <your-repo-url> ~/dev-setup
cd ~/dev-setup

# 2. (Optional) Choose packages
make select

# 3. Install
make install

# 4. (Optional) Delete repo after
cd ~ && rm -rf ~/dev-setup
```

**What happens:**
1. Clone repo locally
2. Choose which packages to install (optional)
3. Installs everything
4. You can delete the repo after if you want

**Benefits:**
- ✅ Preview before installing
- ✅ Customize package selection
- ✅ Keep repo for future updates (optional)
- ✅ No CLI tool installed globally

**Time:** ~15-20 minutes

---

## 🔄 Method 3: Run Scripts Directly

Even more control:

```bash
# Clone
git clone <your-repo-url> ~/dev-setup
cd ~/dev-setup

# Run bootstrap directly
./lib/bootstrap.sh

# Or use make commands
make select          # Choose packages
make dry-run         # Preview
make install         # Install
```

**Perfect for:**
- Developers who want full control
- Testing before actual install
- Custom modifications

---

## ❓ FAQ

### Q: Can I delete the repo after installation?

**A: YES!** If you're not installing the CLI tool, you can safely delete the repo after setup:

```bash
rm -rf ~/dev-setup
```

Everything will continue to work. The installed packages (Homebrew, Node, Docker, etc.) are independent.

---

### Q: How do I update packages later without the CLI?

**A: Use native package managers:**

**macOS:**
```bash
brew update && brew upgrade
```

**Node.js:**
```bash
fnm install --lts
```

**Docker, etc:**
```bash
brew upgrade docker
```

Or keep the repo and use:
```bash
cd ~/dev-setup
make update
```

---

### Q: What if I want the CLI tool later?

**A: Easy! Just install it:**

```bash
# If you kept the repo
cd ~/dev-setup
./scripts/install-cli.sh

# Or clone again
git clone <repo> ~/dev-setup
cd ~/dev-setup
./scripts/install-cli.sh
```

---

### Q: Is the CLI tool worth it?

**Depends on your needs:**

**Skip CLI if:**
- ✅ One-time machine setup
- ✅ Prefer minimal installations
- ✅ Comfortable with native tools

**Install CLI if:**
- ✅ Manage multiple machines
- ✅ Want easy updates: `dev-setup update`
- ✅ Want troubleshooting: `dev-setup doctor`
- ✅ Prefer convenience

---

## 🆚 Comparison

### Without CLI Tool (One-Time)

```bash
# Install
curl -fsSL https://url/install.sh | bash

# Update later (manual)
brew update && brew upgrade
fnm install --lts

# Benefits
✅ Nothing extra installed
✅ Clean system
✅ One and done
```

### With CLI Tool (Ongoing)

```bash
# Install
make install-cli
dev-setup install

# Update later (easy)
dev-setup update

# Benefits
✅ Convenient commands
✅ Easy updates
✅ Built-in health checks
✅ Better for ongoing use
```

---

## 🎯 Recommended Workflows

### Workflow 1: Absolute Minimum

```bash
curl -fsSL https://url/install.sh | bash
# Done! Nothing extra to clean up.
```

---

### Workflow 2: Controlled One-Time Setup

```bash
git clone <repo> ~/dev-setup
cd ~/dev-setup
make select          # Choose what to install
make dry-run         # Preview
make install         # Install
cd ~ && rm -rf ~/dev-setup  # Delete repo
```

---

### Workflow 3: Keep Options Open

```bash
git clone <repo> ~/dev-setup
cd ~/dev-setup
make install

# Keep repo for future updates
# Use: cd ~/dev-setup && make update
# Or install CLI later if needed
```

---

## 📊 What Gets Installed

**Everything except the CLI tool:**

✅ Homebrew (macOS) or apt/dnf (Linux)
✅ Node.js (via fnm)
✅ Go, Python, Docker
✅ VS Code, Browsers, etc.
✅ Dotfiles configuration
✅ Shell setup (Zsh)

❌ **NOT installed:** `dev-setup` global command

Your system is fully set up for development, just without the extra CLI tool.

---

## 💡 Key Takeaway

**You absolutely DO NOT need the CLI tool for one-time setup!**

The CLI is a **convenience tool** for ongoing management. For one-time setup, the scripts work perfectly without it.

Choose what fits your workflow:
- **One-time setup**: Skip the CLI ✅
- **Ongoing management**: Install the CLI ✅

Both are valid approaches! 🎉

---

## 🚀 Next Steps After One-Time Setup

Your system is ready! Here's what you can do:

```bash
# Verify installations
node --version
go version
docker --version
brew list

# Start using your tools
code .              # VS Code
docker run hello-world
```

**You're all set!** No CLI tool needed. 🎉

