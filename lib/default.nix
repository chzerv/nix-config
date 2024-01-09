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
    extraModules ? [],
  }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs outputs hostname username system;};
      modules =
        [
          ../hosts/${hostname}/configuration.nix

          inputs.sops-nix.nixosModules.sops
        ]
        ++ extraModules;
    };

  # home-manager.lib.homeManagerConfiguration wrapper that sets some custom variables and imports
  mkHomeConfig = {
    hostname,
    username,
    system ? "x86_64-linux",
  }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.${system};

      extraSpecialArgs = {
        inherit inputs outputs hostname username system;
      };

      modules = [
        ../hosts/${hostname}/home.nix
        inputs.nix-index-database.hmModules.nix-index
      ];
    };

  forAllSystems = function:
    inputs.nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ] (system: function inputs.nixpkgs.legacyPackages.${system});
}
