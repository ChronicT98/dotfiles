#!/usr/bin/env bash

# Dotfiles Update Script
# Updates configurations from git and restarts services

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo -e "${BLUE}🔄 Updating dotfiles...${NC}"

# Pull latest changes from git
cd "$DOTFILES_DIR"
echo -e "${BLUE}📥 Pulling latest changes from GitHub...${NC}"
git pull

echo -e "${BLUE}🔄 Restarting services...${NC}"

# Restart yabai
if command -v yabai &> /dev/null; then
    yabai --restart-service
    echo -e "${GREEN}✅ yabai restarted${NC}"
else
    echo -e "${YELLOW}⚠️  yabai not found, skipping${NC}"
fi

# Restart skhd
if command -v skhd &> /dev/null; then
    skhd --restart-service
    echo -e "${GREEN}✅ skhd restarted${NC}"
else
    echo -e "${YELLOW}⚠️  skhd not found, skipping${NC}"
fi

echo ""
echo -e "${GREEN}🎉 Update complete!${NC}"
echo ""
