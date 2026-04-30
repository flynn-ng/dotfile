{ pkgs, ... }: {
  users.users.cynte = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "podman" ];
  };
}
