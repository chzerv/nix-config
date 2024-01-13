{
  description = "My NixOS and Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-23.11";

    # Hardware configs
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # Secret management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim nightly
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";

    # Contains every possible VSCode extension there is
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    disko,
    ...
  } @ inputs: let
    inherit (self) outputs;

    myLib = import ./lib {inherit self inputs outputs;};
  in {
    # NixOS Configurations
    nixosConfigurations = {
      # Main Desktop PC
      jupiter = myLib.mkNixosConfig {
        hostname = "jupiter";
        username = "chzerv";
        type = "desktop";
        extraModules = [
          disko.nixosModules.disko
        ];
      };

      luna = myLib.mkNixosConfig {
        hostname = "luna";
        username = "chzerv";
        type = "laptop";
        extraModules = [
          disko.nixosModules.disko
        ];
      };
    };

    # Home Manager Configurations
    homeConfigurations = {
      "chzerv@jupiter" = myLib.mkHomeConfig {
        hostname = "jupiter";
        username = "chzerv";
        type = "desktop";
      };

      "chzerv@luna" = myLib.mkHomeConfig {
        hostname = "luna";
        username = "chzerv";
        type = "laptop";
      };
    };

    # Custom packages
    packages = myLib.forAllSystems (pkgs: import ./pkgs {inherit pkgs;});

    devShells = myLib.forAllSystems (
      pkgs: import ./shell.nix {inherit pkgs;}
    );

    # For `nix fmt`
    # I know https://github.com/numtide/treefmt-nix is a thing, but I kinda prefer configuring
    # `treefmt` in TOML.
    formatter = myLib.forAllSystems (pkgs: pkgs.treefmt);
  };
}
