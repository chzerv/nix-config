{
  inputs,
  pkgs,
  username,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-pc
    inputs.nixos-hardware.nixosModules.common-pc-ssd
    inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.nixos-hardware.nixosModules.common-cpu-amd-pstate
    inputs.nixos-hardware.nixosModules.common-hidpi
    ./disks.nix
    ./hardware-configuration.nix
    ../../nixos
    ../../nixos/hardware/systemd-boot
    ../../nixos/hardware/graphics/amd.nix
    ../../nixos/hardware/btrfs
  ];

  config = {
    local.sys = {
      security = {
        firewall = true;
        sysctl_hardening = true;
      };
      services = {
        bluetooth = true;
        psd = true;
        opensnitch = false;
        openssh = true;
        snapper = true;
        ppd = true;
        tlp = false;
        tailscale = {
          enable = true;
          routingFeatures = "client";
        };
      };
      desktop = {
        gaming = false;
        flatpak = true;
        plymouth = true;
        mount_smb_share = true;
        gnome = true;
      };
      virt = {
        podman = false;
        docker = true;
        libvirt = true;
        vagrant = true;
      };
    };

    system.stateVersion = "23.11";

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      kernel.sysctl = {
        # Disable core dumps
        "kernel.core_pattern" = "/dev/null";
        # Enable sysrq
        "kernel.sysrq" = 1;
      };
    };

    zramSwap = {
      enable = true;
      algorithm = "zstd";
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
            "networkmanager"
            "power"
            "audio"
            "video"
            "input"
            "render"
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
