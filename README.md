# Dotfiles - macOS Window Management Setup

Personal configuration files for **yabai** (tiling window manager) and **skhd** (hotkey daemon) on macOS.

## Features

- 🪟 **BSP Tiling Layout** - Binary Space Partitioning for efficient window management
- ⌨️ **German Keyboard Support** - Optimized shortcuts for German keyboard layout
- 🎨 **Window Animations** - Smooth transitions with configurable easing
- 🔄 **Window Opacity** - Visual focus indication with opacity changes
- 🎯 **Floating Window Management** - Advanced positioning and resizing for floating windows
- 🚀 **Quick Installation** - One-script setup for new machines

## Quick Start

### Installation

```bash
# Clone the repository
git clone <your-repo-url> ~/dotfiles

# Run the installation script
cd ~/dotfiles
./install.sh
```

The installation script will:
- Install Homebrew (if not present)
- Install yabai and skhd
- Create symlinks to config files
- Start both services

### Manual Installation

If you prefer manual setup:

```bash
# Install yabai and skhd
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd

# Create config directories
mkdir -p ~/.config/yabai
mkdir -p ~/.config/skhd

# Link config files
ln -s ~/dotfiles/.config/yabai/yabairc ~/.config/yabai/yabairc
ln -s ~/dotfiles/.config/skhd/skhdrc ~/.config/skhd/skhdrc

# Make yabairc executable
chmod +x ~/.config/yabai/yabairc

# Start services
yabai --start-service
skhd --start-service
```

## Keyboard Shortcuts

### Navigation (Window Focus)
- `alt + arrow keys` - Focus window in direction
- `ctrl + 1-9` - Focus space by number
- `ctrl + left/right` - Focus previous/next space
- `ctrl + tab` - Focus most recent space

### Moving Windows
- `shift + alt + arrow keys` - Swap windows
- `alt + cmd + arrow keys` - Warp window (move and reflow)
- `alt + 1-5` - Move window to space 1-5
- `shift + alt + n/b` - Move window to next/previous space

### Resizing Windows
- `ctrl + alt + arrow keys` - Resize window
- `ctrl + alt + e` - Balance all windows

### Floating Window Management

#### Positioning
- `shift + alt + h` - Left half
- `shift + alt + l` - Right half
- `shift + alt + f` - Fullscreen
- `shift + alt + c` - Center (medium - 50%)
- `shift + alt + m` - Center (large - 80%)
- `shift + alt + s` - Center (small - 40%)

#### Corners
- `shift + alt + u` - Top-left
- `shift + alt + i` - Top-right
- `shift + alt + j` - Bottom-left
- `shift + alt + k` - Bottom-right

#### Top/Bottom Half (German keyboard)
- `shift + alt + ,` - Top half
- `shift + alt + .` - Bottom half

#### Resizing Floating Windows
- `shift + cmd + +` - Make larger
- `shift + cmd + -` - Make smaller
- `shift + ctrl + arrow keys` - Move floating window

### Window Controls
- `alt + t` - Toggle float/tile
- `alt + f` - Toggle fullscreen zoom
- `alt + e` - Toggle split orientation
- `alt + r` - Rotate windows 270°
- `shift + alt + r` - Rotate windows 90°
- `alt + x` - Flip along x-axis
- `alt + y` - Flip along y-axis
- `alt + p` - Toggle sticky + picture-in-picture

### Spaces
- `shift + alt + c` - Create new space and move window there

### System
- `ctrl + alt + cmd + r` - Restart yabai and skhd

## Configuration Details

### yabai Settings

- **Layout**: BSP (Binary Space Partitioning)
- **Padding**: 8px on all sides
- **Window Gap**: 6px
- **Window Animations**: 0.25s with `ease_out_circ` easing
- **Opacity**: Active windows at 100%, inactive at 90%
- **Opacity Transition**: 0.15s
- **Mouse Modifier**: `fn` key for moving/resizing with mouse

### Requirements for Full Features

Some features require additional permissions or system modifications:

#### Required Permissions
- **Accessibility** - Required for yabai and skhd to function
- **Screen Recording** - Required for window animations

#### Optional (Advanced Features)
- **Partially Disabled SIP** - Required for:
  - Moving windows between spaces on newer macOS versions
  - Window opacity control
  - Sticky windows
  - Custom window layers

See: [Disabling System Integrity Protection](https://github.com/koekeishiya/yabai/wiki/Disabling-System-Integrity-Protection)

## Useful Commands

```bash
# Restart services
yabai --restart-service
skhd --restart-service

# Stop services
yabai --stop-service
skhd --stop-service

# Reload configuration
yabai --restart-service
skhd --restart-service

# Check if services are running
brew services list

# View yabai information
yabai -m query --windows
yabai -m query --spaces
yabai -m query --displays

# Test keycodes for your keyboard
skhd -o
```

## Customization

### Changing Animation Speed

Edit `~/.config/yabai/yabairc`:

```bash
# Faster animations
yabai -m config window_animation_duration   0.15

# Slower animations
yabai -m config window_animation_duration   0.35

# Different easing
yabai -m config window_animation_easing     ease_in_out_cubic
```

### Adding Custom Shortcuts

Edit `~/.config/skhd/skhdrc`:

```bash
# Example: Add a new shortcut
alt + w : yabai -m window --close
```

For German keyboard special characters, use keycodes. Find them with:
```bash
skhd -o
# Press the key you want to map
```

## Unmanaged Applications

The following applications are set to float by default:
- System Settings
- Calculator
- Finder
- Karabiner-Elements
- QuickTime Player
- Raycast
- ColorSlurp
- Archive Utility

## Updating

To update your dotfiles on the current machine:

```bash
cd ~/dotfiles
git pull
yabai --restart-service
skhd --restart-service
```

## Resources

- [yabai Documentation](https://github.com/koekeishiya/yabai)
- [skhd Documentation](https://github.com/koekeishiya/skhd)
- [yabai Wiki](https://github.com/koekeishiya/yabai/wiki)

## License

Personal configuration files - use as you wish!
