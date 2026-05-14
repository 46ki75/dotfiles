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
stow starship

# Apply all packages at once
stow */
```
