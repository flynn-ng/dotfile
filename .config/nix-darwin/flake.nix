{
  description = "Cynte Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs = {
          follows = "nixpkgs";
        };
      };
    };
  };

  outputs = { self, nix-darwin, nixpkgs, nix-homebrew, rust-overlay }:
    let

      configuration = { pkgs, config, ... }: {
        nixpkgs.overlays = [ rust-overlay.overlays.default ];

        nixpkgs.config.allowUnfree = true;

        environment.systemPackages = with pkgs; [
          tmux
          git
          lazygit
          neovim
          fzf
          ripgrep
          zoxide
          stow
          eza
          jq
          fd
          bat
          tlrc
          toilet

          deno
          bun
          pnpm

          mkalias
          postgresql
          appcleaner
          openvpn
          yazi
          ffmpeg
          poppler
          go
          (rust-bin.stable.latest.default)
          rust-analyzer
          statix
          pkg-config
          openssl
          ngrok
          luajit
          imagemagick
          neofetch

          python312
          ruby

          unrar
          nginx
          rar
          tesseract
          gemini-cli

        ];

        homebrew = {
          enable = true;
          brews = [
            "podman"
            "podman-compose"
            "hashicorp/tap/terraform"
            "cloudflared"
            "mkcert"
            "jupyterlab"
            "pngpaste"
          ];
          casks = [
            "postman"
            # "teamviewer"
            "podman-desktop"
            "the-unarchiver"
            "arc"
            "keycastr"
            "dbeaver-community"
            "steam"
            "epic-games"
            "stremio"
            "ghostty"
            "raycast"
            "appcleaner"
            "microsoft-teams"
            "streamlabs"
            "discord"
            "sf-symbols"
          ];
          taps = [
            {
              name = "hashicorp/tap";
            }
          ];
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
        };

        fonts.packages = [
          pkgs.nerd-fonts.fira-code
        ];

        system.primaryUser = "cynte";


        system.defaults = {
          dock.autohide = true;
          dock.appswitcher-all-displays = true;
          dock.persistent-apps = [
            "/Applications/Ghostty.app"
            # "${pkgs.dbeaver-bin}/Applications/dbeaver.app"
            "/Applications/Arc.app/"
            "/System/Applications/Messages.app"
          ];
          finder.FXPreferredViewStyle = "clmv";
          loginwindow.GuestEnabled = false;
          NSGlobalDomain.AppleICUForce24HourTime = true;
          NSGlobalDomain.AppleInterfaceStyle = "Dark";
          WindowManager.StandardHideDesktopIcons = true;
        };

        system.keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };

        security.pam.services.sudo_local.touchIdAuth = true;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        system.activationScripts.applications.text = ''
          echo "setting up ~/Applications..." >&2
          applications="$HOME/Applications"
          nix_apps="$applications/Nix Apps"

          if ! test -d "$applications"; then
              mkdir -p "$applications"
              chown ${config.system.primaryUser}: "$applications"
              chmod u+w "$applications"
          fi

          rm -rf "$nix_apps"
          mkdir -p "$nix_apps"

          for src in ${config.system.build.applications}/Applications/*.app; do
              ln -s "$src" "$nix_apps/"
          done
        '';


        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Willians-MacBook-Air
      darwinConfigurations.Willian = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
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

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Willian".pkgs;
    };
}
