{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gnumake
    gcc
    unzip
    libtool
    lsof
    delta
    zsh
    tmux

    cargo
    rustc
    jdk21_headless
    nodejs_24
    go
    python3

    docker
    docker-buildx
    docker-compose

    google-cloud-sdk-gce
    obsidian

    tree-sitter

    codex

    ssss
    imagemagick
  ];
}
