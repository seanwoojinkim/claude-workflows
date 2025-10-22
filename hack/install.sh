#!/bin/bash

# install.sh - Install Claude Code workflow to a project
#
# Usage:
#   ./hack/install.sh /path/to/target/project [--update]
#
# Options:
#   --update    Update existing installation (skips backup)

set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

print_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
print_error() { echo -e "${RED}[ERROR]${NC} $1"; }
print_warning() { echo -e "${YELLOW}[WARNING]${NC} $1"; }

# Parse arguments
UPDATE_MODE=false
TARGET_DIR=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --update)
            UPDATE_MODE=true
            shift
            ;;
        *)
            TARGET_DIR="$1"
            shift
            ;;
    esac
done

if [ -z "$TARGET_DIR" ]; then
    echo -e "${BLUE}Install Claude Code Workflow${NC}"
    echo ""
    echo "Usage: $0 /path/to/target/project [--update]"
    echo ""
    echo "This will copy:"
    echo "  • .claude/ directory (agents and documentation)"
    echo "  • hack/ workflow scripts"
    echo "  • thoughts/ directory structure"
    echo ""
    echo "Options:"
    echo "  --update    Update existing installation (skips backup)"
    echo ""
    exit 1
fi

# Validate target directory
if [ ! -d "$TARGET_DIR" ]; then
    print_error "Target directory does not exist: $TARGET_DIR"
    exit 1
fi

if [ "$UPDATE_MODE" = true ]; then
    print_info "Updating Claude Code workflow in: $TARGET_DIR"
else
    print_info "Installing Claude Code workflow to: $TARGET_DIR"
fi
echo ""

# Copy .claude directory
print_info "Copying .claude/ directory..."
if [ -d "$TARGET_DIR/.claude" ]; then
    if [ "$UPDATE_MODE" = true ]; then
        print_info "Updating existing .claude/ directory..."
        rm -rf "$TARGET_DIR/.claude"
    else
        print_warning ".claude/ already exists in target. Backing up to .claude.backup/"
        mv "$TARGET_DIR/.claude" "$TARGET_DIR/.claude.backup"
    fi
fi
cp -r .claude "$TARGET_DIR/"
print_info "✓ .claude/ copied"

# Copy hack scripts
print_info "Copying workflow scripts to hack/..."
mkdir -p "$TARGET_DIR/hack"

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Copy all .sh scripts except install.sh itself
for script in "$SCRIPT_DIR"/*.sh; do
    script_name=$(basename "$script")
    if [ "$script_name" != "install.sh" ] && [ -f "$script" ]; then
        cp "$script" "$TARGET_DIR/hack/"
        chmod +x "$TARGET_DIR/hack/$script_name"
        print_info "✓ hack/$script_name copied"
    fi
done

# Copy hack README if it doesn't exist
if [ ! -f "$TARGET_DIR/hack/README.md" ]; then
    if [ -f "$SCRIPT_DIR/README.md" ]; then
        cp "$SCRIPT_DIR/README.md" "$TARGET_DIR/hack/"
        print_info "✓ hack/README.md copied"
    fi
else
    print_warning "hack/README.md already exists, skipping"
fi

# Create thoughts directory structure
print_info "Creating thoughts/ directory structure..."
mkdir -p "$TARGET_DIR/thoughts"/{research,plans,implementation-details,reviews,learning}

# Add .gitkeep files
for dir in research plans implementation-details reviews learning; do
    touch "$TARGET_DIR/thoughts/$dir/.gitkeep"
done
print_info "✓ thoughts/ structure created"

# Add to .gitignore if it exists
if [ -f "$TARGET_DIR/.gitignore" ]; then
    if ! grep -q "thoughts/" "$TARGET_DIR/.gitignore"; then
        print_info "Adding thoughts/ to .gitignore (keeping .gitkeep files)..."
        cat >> "$TARGET_DIR/.gitignore" << 'EOF'

# Claude Code workflow - keep directory structure but ignore documents
thoughts/**/*.md
!thoughts/**/.gitkeep
EOF
        print_info "✓ .gitignore updated"
    else
        print_warning "thoughts/ already in .gitignore, skipping"
    fi
fi

echo ""
if [ "$UPDATE_MODE" = true ]; then
    print_info "🎉 Update complete!"
else
    print_info "🎉 Installation complete!"
fi
echo ""
echo "Next steps in your target project:"
echo "  1. Restart Claude Code to register the agents"
echo "  2. Review .claude/README.md for workflow documentation"
echo "  3. Test the workflow with a small feature"
echo ""
echo "Quick test:"
echo "  cd $TARGET_DIR"
echo "  ./hack/generate_frontmatter.sh research \"Test Research\" --research-question \"How does X work?\""
echo ""
