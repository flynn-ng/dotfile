# dotfiles
Install nix-darwin via https://github.com/nix-darwin/nix-darwin

clone this dotfile repository
```
git clone https://github.com/flynn-ng/dotfiles ~/dotfiles
```

Update nix flake
```
sudo nix flake update
```

Install darwin-rebuild
```
sudo nix run nix-darwin -- switch -- flake .#cynte
```

Install rossetta
```
softwareupdate --install-rosetta
```

Set up stow
```
cd ~/dotfiles
stow -t ~ .
```
