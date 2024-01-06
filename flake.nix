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
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
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
      };
    };

    # Home Manager Configurations
    homeConfigurations = {
      "chzerv@jupiter" = myLib.mkHomeConfig {
        hostname = "jupiter";
        username = "chzerv";
      };
    };

    packages = myLib.forAllSystems (pkgs: import ./pkgs {inherit pkgs;});

    # Setup a devshell containing all the dependencies needed for
    # deploying my dotfiles on a fresh system
    devShells = myLib.forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
    );

    overlays = import ./overlays {inherit inputs;};
  };
}
