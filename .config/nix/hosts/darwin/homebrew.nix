{ ... }: {
  homebrew = {
    enable = true;
    brews = [

    ];
    casks = [
      "podman-desktop"
      "the-unarchiver"
      "arc"
      "keycastr"
      "dbeaver-community"
      "steam"
      "stremio"
      "ghostty"
      "raycast"
      "discord"
      "sf-symbols"
      "microsoft-teams"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
