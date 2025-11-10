#!/usr/bin/env bash

# Dotfiles Installation Script
# Author: Tobias Kafka
# Description: Installs yabai and skhd configurations

set -e

echo "🚀 Starting dotfiles installation..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}📁 Dotfiles directory: ${DOTFILES_DIR}${NC}"

# Function to create symlink
create_symlink() {
    local source=$1
    local target=$2

    # Create target directory if it doesn't exist
    mkdir -p "$(dirname "$target")"

    # Backup existing file if it exists and is not a symlink
    if [ -f "$target" ] && [ ! -L "$target" ]; then
        echo -e "${YELLOW}⚠️  Backing up existing file: ${target}${NC}"
        mv "$target" "${target}.backup.$(date +%Y%m%d_%H%M%S)"
    fi

    # Remove existing symlink if it exists
    if [ -L "$target" ]; then
        rm "$target"
    fi

    # Create new symlink
    ln -s "$source" "$target"
    echo -e "${GREEN}✅ Linked: ${target} -> ${source}${NC}"
}

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}📦 Homebrew not found. Installing...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo -e "${GREEN}✅ Homebrew already installed${NC}"
fi

# Install yabai if not already installed
if ! command -v yabai &> /dev/null; then
    echo -e "${BLUE}📦 Installing yabai...${NC}"
    brew install koekeishiya/formulae/yabai
else
    echo -e "${GREEN}✅ yabai already installed${NC}"
fi

# Install skhd if not already installed
if ! command -v skhd &> /dev/null; then
    echo -e "${BLUE}📦 Installing skhd...${NC}"
    brew install koekeishiya/formulae/skhd
else
    echo -e "${GREEN}✅ skhd already installed${NC}"
fi

# Create symlinks for config files
echo -e "${BLUE}🔗 Creating symlinks...${NC}"
create_symlink "${DOTFILES_DIR}/.config/yabai/yabairc" "${HOME}/.config/yabai/yabairc"
create_symlink "${DOTFILES_DIR}/.config/skhd/skhdrc" "${HOME}/.config/skhd/skhdrc"

# Make yabairc executable
chmod +x "${DOTFILES_DIR}/.config/yabai/yabairc"
chmod +x "${HOME}/.config/yabai/yabairc"

# Start services
echo -e "${BLUE}🚀 Starting services...${NC}"

# Start yabai
yabai --start-service
echo -e "${GREEN}✅ yabai service started${NC}"

# Start skhd
skhd --start-service
echo -e "${GREEN}✅ skhd service started${NC}"

echo ""
echo -e "${GREEN}🎉 Installation complete!${NC}"
echo ""
echo -e "${YELLOW}⚠️  Important next steps:${NC}"
echo "1. Grant Accessibility permissions to yabai and skhd in System Settings"
echo "2. Grant Screen Recording permissions to yabai (required for animations)"
echo "3. For advanced features, consider partially disabling SIP:"
echo "   https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection"
echo ""
echo -e "${BLUE}📖 Useful commands:${NC}"
echo "  yabai --restart-service    # Restart yabai"
echo "  skhd --restart-service     # Restart skhd"
echo "  yabai --stop-service       # Stop yabai"
echo "  skhd --stop-service        # Stop skhd"
echo ""
