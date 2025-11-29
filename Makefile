# Development Environment Setup - Makefile
# Simple commands for one-time setup

.PHONY: help install update select check test clean

help:
	@echo "🚀 Development Environment Setup"
	@echo ""
	@echo "Available commands:"
	@echo "  make install        - Install packages (standard)"
	@echo "  make install-min    - Minimal installation"
	@echo "  make install-full   - Full installation"
	@echo "  make select         - Choose packages interactively"
	@echo "  make update         - Update all packages"
	@echo "  make check          - Check package status"
	@echo "  make dry-run        - Preview installation"
	@echo "  make test           - Test scripts"
	@echo "  make clean          - Clean up temporary files"
	@echo ""

install:
	@echo "🚀 Running installation..."
	./lib/bootstrap.sh

install-min:
	@echo "⚡ Running minimal installation..."
	./lib/bootstrap.sh --minimal

install-full:
	@echo "📦 Running full installation..."
	./lib/bootstrap.sh --full

select:
	@echo "📦 Package Selection"
	./lib/select-packages.sh

update:
	@echo "🔄 Updating packages..."
	@if [ -f "./lib/update.sh" ]; then \
		./lib/update.sh; \
	else \
		echo "Update script not found."; \
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

test:
	@echo "🧪 Testing scripts..."
	@bash -n lib/bootstrap.sh && echo "✓ Bootstrap OK"
	@bash -n lib/select-packages.sh && echo "✓ Select packages OK"
	@bash -n lib/update.sh && echo "✓ Update OK"
	@if [ -f "platforms/macos/bootstrap.sh" ]; then bash -n platforms/macos/bootstrap.sh && echo "✓ macOS script OK"; fi
	@if [ -f "platforms/linux/bootstrap.sh" ]; then bash -n platforms/linux/bootstrap.sh && echo "✓ Linux script OK"; fi

clean:
	@echo "🧹 Cleaning up..."
	@rm -f .system-setup-config.tmp
	@rm -f .package-categories.backup
	@echo "Done!"

reset-selection:
	@echo "🔄 Resetting package selection..."
	@rm -f .package-categories
	@echo "Run 'make select' to choose packages again"
