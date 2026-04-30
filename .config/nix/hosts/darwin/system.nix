{ config, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.hostPlatform = "aarch64-darwin";

  networking.hostName = "cynte";
  networking.localHostName = "cynte";
  networking.computerName = "cynte";

  system.defaults = {
    ".GlobalPreferences"."com.apple.mouse.scaling" = -1.0;
    dock.autohide = true;
    dock.appswitcher-all-displays = true;
    dock.persistent-apps = [
      {
        spacer = {
          small = true;
        };
      }
      {
        app = "/Applications/Arc.app";
      }
      {
        app = "/Applications/Steam.app";
      }
      {
        app = "/Applications/Ghostty.app";
      }

    ];
    dock.static-only = true;

    dock.wvous-bl-corner = 1;
    dock.wvous-tl-corner = 1;
    dock.wvous-br-corner = 1;
    dock.wvous-tr-corner = 1;
    finder.FXPreferredViewStyle = "clmv";
    finder.QuitMenuItem = true;
    loginwindow.GuestEnabled = false;
    hitoolbox.AppleFnUsageType = "Change Input Source";
    NSGlobalDomain.AppleICUForce24HourTime = true;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    NSGlobalDomain.AppleIconAppearanceTheme = "TintedLight";
    NSGlobalDomain.AppleShowAllExtensions = true;
    NSGlobalDomain.AppleShowAllFiles = true;
    NSGlobalDomain._HIHideMenuBar = true;
    NSGlobalDomain.ApplePressAndHoldEnabled = false;
    NSGlobalDomain.InitialKeyRepeat = 15;
    NSGlobalDomain.KeyRepeat = 2;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain."com.apple.trackpad.trackpadCornerClickBehavior" = 1;
    NSGlobalDomain."com.apple.trackpad.enableSecondaryClick" = true;
    WindowManager.StandardHideDesktopIcons = true;
    WindowManager.AutoHide = true;
    magicmouse.MouseButtonMode = "OneButton";
    trackpad.Clicking = true;
    trackpad.Dragging = true;
    trackpad.TrackpadCornerSecondaryClick = 2;
    trackpad.TrackpadRightClick = false;
  };
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };
  system.primaryUser = "cynte";
  system.stateVersion = 5;
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


  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true;
  };
}
