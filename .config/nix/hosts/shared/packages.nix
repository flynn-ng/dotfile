{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    git
    curl
    tmux
    neovim
    fzf
    ripgrep
    zoxide
    stow
    eza
    jq
    fd
    bat
    direnv
    tlrc
    lazygit

    starship

    podman
    podman-compose
  ];
}
