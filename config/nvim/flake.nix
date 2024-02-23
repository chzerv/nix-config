{
  description = "Neovim-nightly, wrapped with my custom configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "aarch64-linux"
      ] (system:
        function (import nixpkgs {
          inherit system;
          overlays = [
            inputs.neovim-nightly.overlays.default
          ];
        }));
  in {
    packages = forAllSystems (pkgs: let
      runtimeDeps = with pkgs; [
        luajit
        luajitPackages.luarocks
        luajitPackages.jsregexp
        gnumake
        gcc
        ripgrep
        fd
        fzf
        tree-sitter
        yarn
        nodePackages.npm
        nodejs

        ## YAML
        nodePackages_latest.yaml-language-server # LSP
        yamllint # Linter

        ## Terraform
        terraform-ls # LSP

        # Formatters & Linters
        nodePackages_latest.prettier

        ## Bash
        nodePackages_latest.bash-language-server ## LSP
        shellcheck ## Static analysis
        shfmt

        ## Lua
        lua-language-server # LSP
        stylua # Formatter

        ## Python
        black
        nodePackages_latest.pyright

        ## Rust
        rust-analyzer # LSP
        rustfmt # Formatter

        ## Golang
        gopls # go LSP
        delve # go debugger
        gotools # tools like goimports, godoc and more
        gofumpt # Formatter

        ## Nix
        nil # LSP
        alejandra # Formatter

        ## Other
        dockerfile-language-server-nodejs
        jsonnet
        jsonnet-language-server
        texlab # LaTeX LSP
        taplo # TOML LSP/formatter/linter

        # DAP
        lldb
      ];
    in {
      default = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped (pkgs.neovimUtils.makeNeovimConfig {
          customRC = ''

            set runtimepath^=${./.}
            source ${./.}/init.lua
          '';
        }
        // {
          wrapperArgs = [
            "--prefix"
            "PATH"
            ":"
            "${pkgs.lib.makeBinPath runtimeDeps}"
          ];
        });
    });
  };
}
