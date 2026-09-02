# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Setup

### 1. Install GNU Stow

```bash
# Debian / Ubuntu / WSL
sudo apt install stow
```

### 2. Repository structure

Each top-level directory is a "package". Its contents are mirrored into `$HOME` when stowed.

```tree
dotfiles/
├── starship/
│   └── .config/
│       └── starship.toml      # → ~/.config/starship.toml
└── ...
```

### 3. Apply (create symlinks)

```bash
cd ~/dotfiles

# Apply a single package
stow --no-folding starship

# Apply all packages at once
stow --no-folding */
```

`--no-folding` keeps application-managed files out of this repository by linking individual dotfiles instead of entire directories.

### 4. Claude Code status line

The `claude-code` profile in `starship.toml` renders Claude Code's status line, but Claude Code won't use it until it's told to. After stowing `starship`, add the following to `~/.claude/settings.json`:

```json
{
  "statusLine": {
    "type": "command",
    "command": "starship statusline claude-code"
  }
}
```
