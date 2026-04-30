# dotfiles

## macOS (nix-darwin)

Install nix-darwin via https://github.com/nix-darwin/nix-darwin

Clone this repository:
```sh
git clone https://github.com/flynn-ng/dotfiles ~/dotfiles
```

Install Rosetta:
```sh
softwareupdate --install-rosetta
```

Update the flake and apply:
```sh
cd ~/dotfiles/.config/nix
sudo nix flake update
sudo nix run nix-darwin -- switch --flake .#cynte
```

Set up stow:
```sh
cd ~/dotfiles
stow -t ~ .
```

On subsequent updates:
```sh
darwin-rebuild switch --flake ~/dotfiles/.config/nix#cynte
```

---

## WSL (NixOS-WSL)

Install NixOS-WSL by following https://github.com/nix-community/NixOS-WSL

Once inside the NixOS-WSL shell, clone this repository:
```sh
git clone https://github.com/flynn-ng/dotfiles ~/dotfiles
```

Apply the configuration:
```sh
cd ~/dotfiles/.config/nix
sudo nix flake update
sudo nixos-rebuild switch --flake .#WSL
```

Set up stow:
```sh
cd ~/dotfiles
stow -t ~ .
```

On subsequent updates:
```sh
sudo nixos-rebuild switch --flake ~/dotfiles/.config/nix#WSL
```

> **Note:** Install the FiraCode Nerd Font on Windows (not via Nix) so your terminal emulator can render it. Download from https://www.nerdfonts.com/font-downloads
