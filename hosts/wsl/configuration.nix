{
  pkgs,
  username,
  lib,
  ...
}: {
  imports = [
    ../../nixos
  ];

  config = {
    system = {
      openssh.enable = true;
      docker.enable = true;
    };

    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    system.stateVersion = "24.05";

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
    };

    zramSwap = {
      enable = true;
      algorithm = "zstd";
    };

    environment = {
      shells = [pkgs.fish pkgs.bashInteractive];
    };

    programs.fish.enable = true;
    environment.pathsToLink = ["/share/fish"];

    users = {
      users = {
        ${username} = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "users"
          ];
          shell = pkgs.fish;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiulyvJZgSwvB4BLPaT73nEBBP/N3cClBteYYENH2/u chzerv@DESKTOP-MA88Q7C"
          ];
        };
      };
    };
  };
}
