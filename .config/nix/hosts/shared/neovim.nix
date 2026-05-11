{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # LSP Servers
    lua-language-server
    typescript-language-server
    docker-language-server

    # Formatters
    prettier
    nixpkgs-fmt

    # Linters
    eslint_d
    sqruff

    # SQL Tools
    sqls

    # Debug Adapters
    vscode-js-debug

    # Runtime dependencies
    nodejs

    cargo

    tree-sitter

  ];
}
