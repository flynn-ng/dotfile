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
      "cloudflare-warp"
      "steam"
      "stremio"
      "ghostty"
      "raycast"
      "discord"
      "sf-symbols"
    ];
    onActivation.cleanup = "zap";
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;
  };
}
