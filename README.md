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

### 6. Pi themes

`pi/.pi/agent/themes/ikuma-dark.json` and `ikuma-light.json` adapt the palette and syntax tokens from `~/org/46ki75/elmethis/packages/ikuma-theme/scripts/colors.ts`. They are standalone snapshots, not automatically synchronized with Elmethis.

From the repository root, deploy only the Pi package without pulling Git changes:

```bash
stow --no-folding pi
```

Run `/reload` in Pi, then select `ikuma-dark` or `ikuma-light` through `/settings`. To preview without changing the saved theme, start Pi with `pi --use-theme ikuma-dark`. For automatic switching on compatible terminals, set `"theme": "ikuma-light/ikuma-dark"` in `~/.pi/agent/settings.json`, preserving its other settings.

- Match the terminal's background to the selected variant; Pi themes do not set the terminal-wide background, font, or opacity.
- Alpha colors are composited in sRGB against each variant's base background, matching Elmethis's Neovim exporter. This includes the light syntax-type color (`#ad592f96` → `#c8967c`), search (`primary` at `0x44` opacity), custom messages (`primary`, `0x10`), tool success/error panels (`green`/`red`, `0x30`), and HTML info panels (`primary`, `0x22`).
- Warning colors follow Elmethis's OpenCode mapping; higher thinking levels use its blue, purple, and magenta ANSI accents, with the maximum level using the active foreground.
- Run `/reload` after editing a symlinked theme if the change does not appear automatically.
