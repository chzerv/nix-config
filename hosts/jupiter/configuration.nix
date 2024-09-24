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
    inputs.nixos-hardware.nixosModules.common-hidpi
    ./disks.nix
    ./hardware-configuration.nix
    ../../nixos
  ];

  config = {
    custom.nix = {
      system = {
        firewall = true;
        sysctl_hardening = true;
        efi = true;
        amd_gpu = true;
        btrfs = true;
        mount_smb_share = true;
      };
      services = {
        bluetooth = true;
        psd = false;
        openssh = true;
        ppd = true;
        tailscale = {
          enable = false;
          routingFeatures = "client";
        };
      };
      software = {
        wireshark = false;
        adb = true;
      };
      desktop = {
        gaming = true;
        flatpak = true;
        plymouth = true;
        plasma = true;
      };
      virt = {
        podman = false;
        docker = true;
        libvirt = true;
        vagrant = true;
      };
    };

    system.stateVersion = "24.05";

    boot = {
      kernelPackages = pkgs.linuxPackages_latest;
      binfmt.emulatedSystems = ["aarch64-linux"];
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
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiulyvJZgSwvB4BLPaT73nEBBP/N3cClBteYYENH2/u chzerv@DESKTOP-MA88Q7C"
          ];
        };
      };
    };

    ##############################################
    # Mount additional disks
    ##############################################

    systemd.tmpfiles.rules = [
      "d /media 0755 ${username} users"
      "d /media/Bravo 0755 ${username} users"
      "d /media/Omega 0755 ${username} users"
    ];

    fileSystems."/media/Bravo" = {
      device = "/dev/disk/by-label/Bravo";
      fsType = "ext4";
      options = [
        "noatime"
      ];
    };

    fileSystems."/media/Omega" = {
      device = "/dev/disk/by-label/Omega";
      fsType = "ntfs";
      options = [
        "noatime,uid=1000,gid=100,rw,user,exec,umask=000 0 0"
      ];
    };
  };
}
