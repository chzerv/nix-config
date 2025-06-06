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
    system = {
      adguard.enable = false;
      bluetooth.enable = true;
      btrfs.enable = true;
      docker.enable = false;
      firewall.enable = true;
      flatpak.enable = true;
      gaming.enable = false;
      libvirt.enable = true;
      node_exporter.enable = false;
      openssh.enable = true;
      plymouth.enable = true;
      podman.enable = true;
      power-profiles.enable = true;
      mount_smb_share.enable = true;
      sysctl_hardening.enable = true;
      systemd-boot.enable = true;
      tailscale = {
        enable = true;
        routingFeatures = "client";
      };
      vagrant.enable = false;
      gnome.enable = true;
      hyprland.enable = false;
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
      shells = with pkgs; [zsh];
      pathsToLink = ["/share/zsh"];
    };

    programs.zsh.enable = true;

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
            "dialout"
          ];
          shell = pkgs.zsh;
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3BmmYPJFi2QBh7luMiYgRqGaZJUM6B7mtgs6AjkYAl chzerv@vader"
          ];
        };
      };
    };
  };
}
