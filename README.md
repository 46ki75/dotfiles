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

### 3. Deploy (create symlinks)

Use `./deploy.sh` from the repository root to deploy the dotfiles:

```bash
cd ~/dotfiles
./deploy.sh
```

The script pulls the latest repository changes and applies all packages with `stow --no-folding`. Linking individual files instead of entire directories keeps newly generated application files out of this repository.

### 4. Claude Code status line

The `claude-code` profile in `starship.toml` renders Claude Code's status line, but Claude Code won't use it until it's told to. After running `./deploy.sh`, merge the following into `~/.claude/settings.json` while preserving any existing settings:

```json
{
  "statusLine": {
    "type": "command",
    "command": "starship statusline claude-code"
  }
}
```

Restart Claude Code to enable the status line. If Claude Code cannot find `starship`, replace `starship` in the command with the absolute path reported by `command -v starship`.

### 5. Neovim / LazyVim

The complete Neovim configuration lives in `nvim/.config/nvim/`. LazyVim and its plugins are installed by `lazy.nvim` when Neovim starts.

```bash
# From the dotfiles repository
./deploy.sh
nvim
```

If `~/.config/nvim` already contains regular configuration files, back them up and reconcile them with the package before deploying.

- Edit options, keymaps, and autocommands in `lua/config/` and plugin overrides in `lua/plugins/`.
- Keep `lazyvim.json` (enabled extras) and `lazy-lock.json` (plugin versions) in version control. Review their changes after using `:LazyExtras` or updating plugins with `:Lazy update`; use `:Lazy restore` to restore the versions in the lockfile.
- Create new configuration files in `nvim/.config/nvim/`, then rerun `./deploy.sh` to link them. Existing symlinked files can be edited through `~/.config/nvim/`.
- Plugin installations, caches, and editor state live outside this repository.
