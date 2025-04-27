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
      quiet_boot = true;
      btrfs = true;
      mount_smb_share = true;
      bluetooth = true;
      gaming = false;
      flatpak = true;
      podman = true;
      docker = false;
      libvirt = true;
      openssh = true;
      ppd = true;
      tailscale = {
        enable = true;
        routingFeatures = "client";
      };
    };

    system.stateVersion = "24.11";

    boot = {
      # kernelPackages = pkgs.linuxKernel.packages.linux_zen;
      kernelPackages = pkgs.linuxPackages_latest;
      binfmt.emulatedSystems = [
        "aarch64-linux"
      ];
    };
    # services.scx = {
    #   enable = true;
    #   # https://wiki.cachyos.org/configuration/sched-ext/
    #   scheduler = "scx_bpfland";
    # };

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
