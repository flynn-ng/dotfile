{ pkgs, ... }: {
  users.users.nixos = {
    isNormalUser = true;
    description = "WSL user";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "docker" ];
  };
}
