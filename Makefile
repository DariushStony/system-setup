# Development Environment Setup - Makefile
# Quick commands for common tasks

.PHONY: help install update check clean test select

help:
	@echo "🚀 Development Environment Setup"
	@echo ""
	@echo "Available commands:"
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
	@echo "💡 Tip: Run 'make select' first to choose what to install"
	@echo ""

select:
	@echo "📦 Package Selection Tool"
	./select-packages.sh

install:
	@echo "🚀 Running bootstrap..."
	./bootstrap.sh

install-min:
	@echo "⚡ Running minimal installation..."
	./bootstrap.sh --minimal

install-full:
	@echo "📦 Running full installation..."
	./bootstrap.sh --full

update:
	@echo "🔄 Updating packages..."
	@if [ -f "./update.sh" ]; then \
		./update.sh; \
	else \
		echo "Update script not found. Run 'make install' first."; \
	fi

check:
	@echo "🔍 Checking package status..."
	@if [ "$$(uname -s)" = "Darwin" ]; then \
		brew bundle check --file=macos/Brewfile || echo "Some packages missing"; \
	else \
		echo "Check not available on this platform"; \
	fi

dry-run:
	@echo "👀 Previewing installation..."
	./bootstrap.sh --dry-run

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
	@echo "🧪 Testing bootstrap script..."
	@bash -n bootstrap.sh && echo "✓ Syntax OK"
	@if [ -f "macos/bootstrap.sh" ]; then bash -n macos/bootstrap.sh && echo "✓ macOS script OK"; fi
	@if [ -f "linux/bootstrap.sh" ]; then bash -n linux/bootstrap.sh && echo "✓ Linux script OK"; fi

