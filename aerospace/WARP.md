# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is an AeroSpace window manager configuration repository. AeroSpace is a tiling window manager for macOS with i3-like functionality. The configuration provides:

- Automated window tiling and management
- Extensive application-to-workspace assignments for productivity workflows
- Dual-monitor workspace distribution
- Vim-style navigation keybindings
- Custom modes for different operations (main, service)

## Common Commands

```bash
# Essential AeroSpace commands
aerospace reload-config              # Reload configuration after changes (ALWAYS run after config edits)
aerospace list-windows              # Show all windows and their workspaces
aerospace list-workspaces           # List available workspaces
aerospace list-workspaces --monitor focused --empty  # Find empty workspaces on current monitor

# Window and workspace management
aerospace focus left/down/up/right  # Navigate between windows (alt+hjkl)
aerospace move left/down/up/right   # Move windows (alt+shift+hjkl)
aerospace workspace [workspace]     # Switch to workspace (alt+[key])
aerospace move-node-to-workspace [workspace]  # Move window to workspace (alt+shift+[key])

# Layout commands
aerospace layout tiles horizontal vertical    # Toggle tiling layout (alt+/)
aerospace layout accordion horizontal vertical # Toggle accordion layout (alt+,)
aerospace layout floating tiling             # Toggle floating mode (service mode + f)

# Service mode operations (alt+shift+;)
aerospace flatten-workspace-tree    # Reset workspace layout (service mode + r)
aerospace close-all-windows-but-current  # Close other windows (service mode + backspace)
```

## Configuration Architecture

The configuration is structured around several key components:

### Core Files
- `aerospace.toml` - Main configuration file
- `CHANGELOG.md` - Version history and modification tracking
- `CLAUDE.md` - AI assistant guidelines

### Configuration Sections

**Startup & Behavior**
- `start-at-login` - Auto-start configuration
- `after-startup-command` - Commands to run on startup
- Normalization settings for container management

**Layout & Appearance**
- Zero window gaps (`inner/outer` all set to 0) for compact layout
- `default-root-container-layout` - tiles vs accordion
- `accordion-padding` - spacing in accordion mode

**Workspace Management**
- Dual-monitor setup with `workspace-to-monitor-force-assignment`
- Extensive `[[on-window-detected]]` rules for automatic app placement
- Custom workspace naming: Numbers (1-9), letters (A-Z), special cases

**Keybinding Modes**
- `main` mode - Primary navigation and window management
- `service` mode - Advanced operations and system controls

## Workspace Assignment System

The configuration uses an extensive application-to-workspace mapping system:

### Productivity Workspaces
- **D** - Emacs (development)
- **P** - VS Code
- **2** - Terminal applications
- **E** - Finder (file management)
- **3** - Things (task management)
- **4** - Calendar

### Communication & Browsers
- **B** - Arc, Firefox
- **C** - ChatGPT, Chrome  
- **V** - Claude
- **8** - Messaging (Telegram, WhatsApp, Discord)
- **M** - Gmail

### Documents & Media
- **A** - sioyek (PDF reader), Microsoft Office
- **O** - Books (floating layout)
- **Y** - YouTube
- **Z** - Day One, Obsidian

### Monitor Distribution
- **Main monitor**: Workspace D
- **Secondary monitor**: Workspaces 2-9, E, F, M, Z

## Key Binding Patterns

### Navigation (Vim-style)
- `alt + hjkl` - Focus windows
- `alt + shift + hjkl` - Move windows
- `alt + [key]` - Switch to workspace
- `alt + shift + [key]` - Move window to workspace

### Special Operations
- `alt + tab` - Workspace back-and-forth
- `alt + backtick` - Switch to next empty workspace
- `alt + shift + backtick` - Move window to next empty workspace
- `alt + esc` - Cycle through windows in workspace
- `alt + enter` - Launch terminal

### Service Mode (alt + shift + ;)
- `esc` - Reload config and return to main mode
- `r` - Reset layout (flatten workspace tree)
- `f` - Toggle floating/tiling layout
- `backspace` - Close all windows except current

## Development Workflow

### Making Configuration Changes
1. Edit `aerospace.toml` using your preferred editor
2. **ALWAYS** run `aerospace reload-config` after changes
3. Test the changes with affected applications
4. Document changes in `CHANGELOG.md` if significant
5. Commit changes to version control

### Testing and Validation
```bash
# Verify configuration syntax
aerospace reload-config  # Will show errors if config is invalid

# Test workspace assignments
aerospace list-windows   # Check current window placements

# Debug window detection
# Open target application and check if it appears in correct workspace
```

### Troubleshooting
- Check for typos in app names using `aerospace list-windows`
- Verify workspace names match keybinding definitions
- Use `mdls /Applications/App.app` to get correct app identifiers
- Monitor system console for AeroSpace error messages

## Important Configuration Notes

### App Detection Rules
- Uses `app-name-regex-substring` for flexible app matching
- Some apps use `app-id` (bundle identifier) for precise targeting
- Case-sensitive matching for application names

### Workspace Conventions
- Numbers (1-9) for general productivity
- Letters for specific application categories
- Disabled bindings: E, X (commented out in some contexts)

### Monitor Management
- Primary workspace assignments favor secondary monitor
- Workspace D reserved for main monitor (development)
- Mouse follows focus when switching monitors

### Custom Scripts
- Empty workspace navigation uses shell command integration
- Safari private browsing launcher via AppleScript
- Volume controls integrated in service mode

## WARP Integration Tips

When working with this configuration in WARP:

- Use WARP's command palette for quick aerospace command execution
- Leverage WARP's AI to generate complex workspace manipulation commands
- Set up WARP workflows for common configuration editing tasks
- Use WARP's git integration for tracking configuration changes

Remember: The configuration follows XDG Base Directory specification and lives in `~/.config/aerospace/` rather than the home directory.
