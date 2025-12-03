# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Overview

This repository contains personal development environment configuration files for zsh, tmux, neovim, and git. The configurations are designed for a MacOS development environment with support for JavaScript/TypeScript, Go, and other languages.

## Repository Structure

### Three Main Configuration Groups

1. **Zsh Shell Configuration** (`aliases.zsh`, `zsh/`)
   - Shell aliases and custom functions
   - Path configurations for nvm, yarn, Go, and ghcup
   - Powerline fonts integration

2. **Tmux Configuration** (`tmux-config/`)
   - Based on [samoshkin/tmux-config](https://github.com/samoshkin/tmux-config)
   - Supports nested tmux sessions (local + remote)
   - Custom status line with system metrics
   - Prefix: `C-a` (screen-style)
   - Remote session detection via `$SSH_CLIENT`

3. **Neovim Configuration** (`nvim/`)
   - Built on [NVChad](https://nvchad.com) framework
   - Customized for Next.js/TypeScript development
   - Uses lazy.nvim for plugin management
   - Custom configurations in `nvim/lua/custom/`

## Installation

### Zsh Setup
```bash
# Install oh-my-zsh and required plugins
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# Install Powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

# Install zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Install thefuck
brew install thefuck

# Source the aliases
# Add to .zshrc: source /path/to/configs/aliases.zsh
```

### Tmux Setup
```bash
# Install tmux if not present
brew install tmux

# Run the installer script
./tmux-config/install.sh
```

The install script:
- Copies files to `~/.tmux` directory
- Symlinks `~/.tmux.conf` (backs up existing)
- Installs Tmux Plugin Manager (TPM) at `~/.tmux/plugins/tpm`
- Installs required tmux plugins

### Neovim Setup
```bash
# This configuration expects NVChad to be installed first
# Clone custom config into NVChad's custom directory
git clone <this-repo> $HOME/.config/nvim/lua/custom
```

## Key Custom Functions

### `find_port <port>`
Finds processes listening on a specific port.
```bash
find_port 5000
```

### `monday()`
Automated system maintenance routine for Monday mornings:
- Updates all Homebrew packages (including casks)
- Runs macOS software update
- Updates Mac App Store apps via `mas`
- Cleans up Homebrew cellar
- Prunes Docker images, containers, and volumes

### `pingsay()`
Provides audible feedback for network connectivity by pinging 8.8.8.8 and using text-to-speech.

## Neovim LSP Configuration

### Supported Language Servers
- **TypeScript/JavaScript**: `ts_ls`, `eslint`, `tailwindcss`
- **Go**: `gopls` (with gofumpt, staticcheck)
- **Svelte**: `svelte`
- **Lua**: `lua-language-server`

### Auto-formatting Behavior
- **ESLint**: Auto-fixes on save for TS/JS files
- **Prettier**: Runs on save when `package.json` or `.prettierrc` exists
- **Go**: Format on save with gofumpt

### LSP Root Detection
TypeScript/ESLint use `tsconfig.json` for project root detection. Files without a `tsconfig.json` in their directory tree won't activate the language server.

## Git Configuration Highlights

Custom git aliases defined in `.gitconfig`:
- `git lg` - Graphical log with colors (current branch only)
- `git lga` - Graphical log showing all branches
- `git lastdiff` - Diff between last two commits
- `git findv <string>` - Search commit history for code changes (better than blame)
- `git who` - Show commit counts by author

Advanced merge/diff settings:
- Conflict style: `zdiff3` (shows base, ours, and theirs)
- Diff algorithm: `histogram` with `dimmed-zebra` for moved code
- Rerere enabled (reuse recorded resolution)

## Tmux Key Bindings (Custom)

Important bindings differ from defaults:
- **Prefix**: `C-a` (not `C-b`)
- **Split horizontal**: `<prefix> _`
- **Split vertical**: `<prefix> |`
- **Navigate panes**: `<prefix> ←↑→↓`
- **Resize panes**: `<prefix> C-←↑→↓`
- **Toggle nested session**: `F12` (disables outer session keybindings)
- **Edit config**: `<prefix> C-e`
- **Reload config**: `<prefix> C-r`

### Nested Session Support
Press `F12` to toggle outer session keybindings when working with a nested remote session. Status line shows `[OFF]` indicator when disabled.

## Development Environment Paths

The configuration expects these tools to be available:
- **nvm**: `/opt/homebrew/opt/nvm/nvm.sh` (Node version manager)
- **Go binaries**: `$HOME/go/bin`
- **Yarn global**: `$HOME/.yarn/bin`
- **ghcup**: `$HOME/.ghcup/env` (Haskell toolchain)
- **nvim**: Aliased to `vim`

## Docker Maintenance Commands

Reference commands in `docker-commands.md`:
```bash
# Cleanup all unused Docker resources
docker system prune -f

# Remove dangling volumes (careful!)
docker volume rm $(docker volume ls -qf dangling=true)
```
