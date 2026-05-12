{ ... }: {
  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.auto-optimise-store = true;

  time.timeZone = "Asia/Ho_Chi_Minh";

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [ ];
  programs.neovim.defaultEditor = true;
  programs.nano.enable = false;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  system.stateVersion = "25.05";
}
