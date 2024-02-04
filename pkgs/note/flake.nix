{
  description = "Golang Development Environment";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    gomod2nix = {
      url = "github:tweag/gomod2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-parts,
    gomod2nix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      perSystem = {
        system,
        pkgs,
        ...
      }: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [gomod2nix.overlays.default];
        };
      in {
        formatter = pkgs.treefmt;

        packages = {
          default = pkgs.buildGoApplication {
            pname = "note";
            version = "0.1.0";
            src = ./.;
            pwd = ./.;
            modules = ./gomod2nix.toml;
          };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            go
            go-tools
            golangci-lint
            gopls
            gofumpt
            gomod2nix.packages.${system}.default
          ];
        };
      };
    };
}
