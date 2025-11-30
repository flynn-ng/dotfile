{ ... }: {
  users.users.cynte = {
    isNormalUser = true;
    extraGroups = [ "wheel" "podman" ];
  };
}
