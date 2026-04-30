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

    # Treesitter parsers (native Neovim 0.11+ support)
    tree-sitter-grammars.tree-sitter-lua
    tree-sitter-grammars.tree-sitter-typescript
    tree-sitter-grammars.tree-sitter-javascript
    tree-sitter-grammars.tree-sitter-tsx
    tree-sitter-grammars.tree-sitter-json
    tree-sitter-grammars.tree-sitter-yaml
    tree-sitter-grammars.tree-sitter-toml
    tree-sitter-grammars.tree-sitter-html
    tree-sitter-grammars.tree-sitter-css
    tree-sitter-grammars.tree-sitter-bash
    tree-sitter-grammars.tree-sitter-vim
    tree-sitter-grammars.tree-sitter-dockerfile
    tree-sitter-grammars.tree-sitter-sql
    tree-sitter-grammars.tree-sitter-go
    tree-sitter-grammars.tree-sitter-rust
    tree-sitter-grammars.tree-sitter-python
    tree-sitter-grammars.tree-sitter-nix
    tree-sitter-grammars.tree-sitter-regex
  ];
}
