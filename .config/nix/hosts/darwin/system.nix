{ config, ... }: {
  nix.settings.experimental-features = "nix-command flakes";

  nixpkgs.hostPlatform = "aarch64-darwin";

  system.defaults = {
    dock.autohide = true;
    dock.appswitcher-all-displays = true;
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
