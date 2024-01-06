{
  inputs,
  outputs,
  ...
}: {
  # lib.nixosSystem wrapper that sets some custom variables and imports
  mkNixosConfig = {
    hostname,
    username ? "chzerv",
    system ? "x86_64-linux",
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs hostname username system;};
      modules = [
        ../hosts/${hostname}/configuration.nix

        inputs.sops-nix.nixosModules.sops
      ];
    };

  # home-manager.lib.homeManagerConfiguration wrapper that sets some custom variables and imports
  mkHomeConfig = {
    hostname,
    username,
    system ? "x86_64-linux",
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      extraSpecialArgs = let
        configDir = ../config;
      in {
        inherit inputs outputs hostname username system configDir;
      };

      modules = [../hosts/${hostname}/home.nix];
    };

  forAllSystems = inputs.nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux"];
}
