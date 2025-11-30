{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lua-language-server
    typescript-language-server
    docker-language-server

    prettier
    eslint_d
    nixpkgs-fmt
    sqruff
    sqls

    vscode-js-debug

    nodejs
  ];
}
