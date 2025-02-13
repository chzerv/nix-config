{
  inputs,
  pkgs,
  username,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-hidpi
    ./disks.nix
    ./hardware-configuration.nix
    ../../nixos
  ];

  config = {
    features.nix = {
      firewall = true;
      sysctl_hardening = true;
      efi = true;
      amd_gpu = true;
      btrfs = true;
      mount_smb_share = true;
      bluetooth = true;
      zram = true;
      gaming = false;
      flatpak = true;
      quiet_boot = true;
      podman = false;
      docker = true;
      libvirt = true;
      openssh = true;
      ppd = true;
      tailscale = {
        enable = true;
        routingFeatures = "client";
      };
    };

    system.stateVersion = "23.11";

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
    };

    environment = {
      shells = [pkgs.fish pkgs.bashInteractive];
    };

    programs.fish.enable = true;

    users = {
      users = {
        ${username} = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "users"
            "power"
            "audio"
            "input"
          ];
          shell = pkgs.fish;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3BmmYPJFi2QBh7luMiYgRqGaZJUM6B7mtgs6AjkYAl chzerv@vader"
          ];
        };
      };
    };
  };
}
