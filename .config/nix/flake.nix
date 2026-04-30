{
  description = "Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    tmux-powerkit = {
      url = "github:fabioluciano/tmux-powerkit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, nix-homebrew, nix-wsl, tmux-powerkit }:
    let
      sharedModules = [
        hosts/shared/packages.nix

        hosts/shared/nixpkgs.nix

        hosts/shared/fonts.nix

        hosts/shared/neovim.nix

        hosts/shared/tmux.nix
      ];
    in
    {
      darwinConfigurations.cynte = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = { inherit tmux-powerkit; };
        modules = sharedModules ++ [
          hosts/darwin/common.nix

          hosts/darwin/homebrew.nix

          hosts/darwin/system.nix

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = "cynte";
            };
          }
        ];
      };
      nixosConfigurations.WSL = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit tmux-powerkit; };
        modules = sharedModules ++ [
          hosts/nixos/virtualization.nix

          hosts/nixos/users.nix

          hosts/nixos/packages.nix

          hosts/nixos/system.nix

          hosts/nixos/wsl.nix

          nix-wsl.nixosModules.default
        ];
      };

    };
}
