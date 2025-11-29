# Development Environment Setup - Makefile
# Quick commands for common tasks

.PHONY: help install update check clean test select install-cli

help:
	@echo "🚀 Development Environment Setup"
	@echo ""
	@echo "Available commands:"
	@echo "  make install-cli    - Install dev-setup CLI tool globally"
	@echo "  make select         - Choose which packages to install"
	@echo "  make install        - Run bootstrap setup"
	@echo "  make install-min    - Minimal installation"
	@echo "  make install-full   - Full installation"
	@echo "  make update         - Update all packages"
	@echo "  make check          - Check package status"
	@echo "  make dry-run        - Preview installation"
	@echo "  make clean          - Clean up temporary files"
	@echo "  make test           - Test bootstrap script"
	@echo ""
	@echo "💡 Recommended: Run 'make install-cli' to use 'dev-setup' command anywhere"
	@echo ""

install-cli:
	@echo "📦 Installing dev-setup CLI tool..."
	./scripts/install-cli.sh

select:
	@echo "📦 Package Selection Tool"
	./lib/select-packages.sh

install:
	@echo "🚀 Running bootstrap..."
	./lib/bootstrap.sh

install-min:
	@echo "⚡ Running minimal installation..."
	./lib/bootstrap.sh --minimal

install-full:
	@echo "📦 Running full installation..."
	./lib/bootstrap.sh --full

update:
	@echo "🔄 Updating packages..."
	@if [ -f "./lib/update.sh" ]; then \
		./lib/update.sh; \
	else \
		echo "Update script not found. Run 'make install' first."; \
	fi

check:
	@echo "🔍 Checking package status..."
	@if [ "$$(uname -s)" = "Darwin" ]; then \
		brew bundle check --file=platforms/macos/Brewfile || echo "Some packages missing"; \
	else \
		echo "Check not available on this platform"; \
	fi

dry-run:
	@echo "👀 Previewing installation..."
	./lib/bootstrap.sh --dry-run

clean:
	@echo "🧹 Cleaning up..."
	@rm -f .dev-setup-config.tmp
	@rm -f .package-categories.backup
	@echo "Done!"

reset-selection:
	@echo "🔄 Resetting package selection..."
	@rm -f .package-categories
	@echo "Run 'make select' to choose packages again"

test:
	@echo "🧪 Testing bootstrap scripts..."
	@bash -n lib/bootstrap.sh && echo "✓ Universal bootstrap OK"
	@bash -n bin/dev-setup && echo "✓ CLI tool OK"
	@if [ -f "platforms/macos/bootstrap.sh" ]; then bash -n platforms/macos/bootstrap.sh && echo "✓ macOS script OK"; fi
	@if [ -f "platforms/linux/bootstrap.sh" ]; then bash -n platforms/linux/bootstrap.sh && echo "✓ Linux script OK"; fi

