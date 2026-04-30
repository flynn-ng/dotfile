# dotfiles

A declarative, reproducible system configuration using **Nix flakes** — supporting both macOS (nix-darwin) and WSL (NixOS-WSL) from a single source of truth. Consistent [Cyberdream](https://github.com/scottmckendry/cyberdream.nvim) theming across every tool.

---

## What's inside

| Category | Tools |
|---|---|
| **Shell** | Zsh + Zinit, Starship prompt, Zoxide, FZF, Direnv |
| **Editor** | Neovim (Lua, lazy.nvim) with LSP, linting, formatting, AI completion |
| **Multiplexer** | Tmux with Cyberdream theme, Vim-tmux-navigator, session persistence |
| **Terminal** | Ghostty / Alacritty — FiraCode Nerd Font, 0.7–0.9 opacity |
| **Git** | Lazygit, Gitsigns, Git-aware `eza` listings |
| **CLI utilities** | `ripgrep` · `fd` · `bat` · `eza` · `jq` · `tlrc` · `fzf` |
| **Containers** | Podman + Podman Compose |
| **Secrets** | Bitwarden CLI |
| **AI** | Claude Code CLI, Codeium (inline completion) |
| **Cloud** | Google Cloud SDK (WSL), Cloudflare Warp |

### Neovim LSP / tooling

| Kind | Tools |
|---|---|
| LSP servers | `lua-language-server` · `typescript-language-server` · `docker-language-server` · `sqls` |
| Formatters | `prettier` (JS/TS/HTML/CSS/JSON/YAML/Markdown) · `nixpkgs-fmt` |
| Linters | `eslint_d` · `sqruff` |
| Debug | `vscode-js-debug` |
| Tree-sitter | lua · ts · js · tsx · json · yaml · toml · html · css · bash · dockerfile · sql · go · rust · python · nix |

---

## macOS (nix-darwin, aarch64)

### 1. Install nix-darwin

Follow the official guide: https://github.com/nix-darwin/nix-darwin

### 2. Clone this repo

```sh
git clone https://github.com/flynn-ng/dotfiles ~/dotfiles
```

### 3. Install Rosetta (Apple Silicon)

```sh
softwareupdate --install-rosetta
```

### 4. Apply the flake

```sh
cd ~/dotfiles/.config/nix
sudo nix flake update
sudo nix run nix-darwin -- switch --flake .#cynte
```

### 5. Symlink dotfiles with stow

```sh
cd ~/dotfiles
stow -t ~ .
```

### Subsequent updates

```sh
darwin-rebuild switch --flake ~/dotfiles/.config/nix#cynte
```

### What nix-darwin configures

- **Homebrew** — Arc, Raycast, Ghostty, Discord, Steam, Stremio, Podman Desktop, Cloudflare Warp, Keycastr, SF Symbols, The Unarchiver
- **macOS defaults** — dark mode, 24-hour clock, autohide dock (Arc + Steam + Ghostty pinned), Touch ID for sudo, guest login disabled
- **Keyboard** — Caps Lock → Escape, fast key repeat (InitialKeyRepeat=15, KeyRepeat=2), Fn → Change Input Source
- **Trackpad** — tap to click, two-finger secondary click
- **Finder** — column view, show hidden files and all extensions

---

## WSL (NixOS-WSL, x86_64)

### 1. Install NixOS-WSL

Follow the official guide: https://github.com/nix-community/NixOS-WSL

### 2. Clone this repo

```sh
git clone https://github.com/flynn-ng/dotfiles ~/dotfiles
```

### 3. Apply the flake

```sh
cd ~/dotfiles/.config/nix
sudo nix flake update
sudo nixos-rebuild switch --flake .#WSL
```

### 4. Symlink dotfiles with stow

```sh
cd ~/dotfiles
stow -t ~ .
```

### Subsequent updates

```sh
sudo nixos-rebuild switch --flake ~/dotfiles/.config/nix#WSL
```

> **Note:** Install FiraCode Nerd Font on **Windows** (not via Nix) so your terminal emulator can render Nerd Font glyphs. Download from https://www.nerdfonts.com/font-downloads

---

## Shell (Zsh + Zinit)

Plugins loaded via **Zinit**:

- `zsh-syntax-highlighting` — real-time command syntax coloring
- `zsh-autosuggestions` — fish-style history suggestions
- `zsh-completions` — extended completion definitions
- `fzf-tab` — replaces the default completion menu with an fzf picker (Tmux popup, 80×12)

Key bindings: `Ctrl-P/N` history search, `Ctrl-T` file picker (bat preview), `Alt-C` directory picker (eza tree preview).

Aliases:
```sh
v / vim / vi  →  nvim
ls            →  eza --color=always --git --icons=always -1
cd            →  zoxide (smart jump)
```

---

## Neovim

Modular Lua config managed by **lazy.nvim**. Leader key: `Space`.

### Key mappings (selected)

| Mapping | Action |
|---|---|
| `<leader>e` | File explorer (Snacks picker) |
| `<leader>ff / fs / fg` | Files / smart / git files |
| `<leader>fw` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>ss / sS` | LSP symbols (buffer / workspace) |
| `gd / gD / gr / gI` | Definition / declaration / references / implementation |
| `<leader>ca` | Code action |
| `<leader>rn` | Rename |
| `<leader>mp` | Format (conform.nvim) |
| `<leader>ml` | Lint (nvim-lint) |
| `<leader>lg / lf / ll` | Lazygit / file history / log |
| `<leader>z` | Zen mode |
| `<leader>d` | Diagnostics (Trouble) |
| `K` | Hover docs |

Auto-format and lint on save. Inlay hints toggled with `<leader>i`.

---

## Tmux

- Prefix: `Ctrl-Space`
- Theme: Cyberdream dark (transparent statusbar, top position)
- Vi-mode copy with system clipboard sync (`tmux-yank`)
- Session persistence across reboots (`resurrect` + `continuum`)
- Seamless Vim/Tmux pane navigation (`vim-tmux-navigator`)
- Window navigation: `Alt-H` / `Alt-L`
- Statusbar: session name → tmux-powerkit (git branch, Bitwarden status, CPU, memory, battery, datetime)

---

## Flake structure

```
.config/nix/
├── flake.nix
└── hosts/
    ├── shared/
    │   ├── packages.nix    # Common CLI packages
    │   ├── neovim.nix      # LSP servers, formatters, linters
    │   ├── tmux.nix        # Tmux + Cyberdream theme
    │   ├── fonts.nix       # FiraCode Nerd Font
    │   └── nixpkgs.nix     # Unfree packages enabled
    ├── darwin/
    │   ├── common.nix      # Shell, user setup
    │   ├── homebrew.nix    # Homebrew casks & formulae
    │   └── system.nix      # macOS defaults, dock, keyboard
    └── nixos/
        ├── packages.nix    # NixOS-specific packages (gcloud)
        ├── system.nix
        ├── users.nix
        ├── virtualization.nix
        └── wsl.nix
```

Flake inputs: `nixpkgs` (unstable) · `nix-darwin` · `nix-wsl` · `nix-homebrew` · `tmux-powerkit`
