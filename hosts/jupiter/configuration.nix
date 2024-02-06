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
    ./disks.nix
    ./hardware-configuration.nix
    ../../nixos
    ../../nixos/hardware/gpu/amd.nix
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
        ppd = false;
        tlp = false;
        gpg_agent = true;
        tailscale = {
          enable = false;
          routingFeatures = "client";
        };
      };
      desktop = {
        gaming = true;
        flatpak = true;
        plymouth = true;
        mount_smb_share = true;
      };
      virt = {
        podman = true;
        docker = false;
        libvirt = true;
        vagrant = true;
      };
    };

    # These might differ from host to host (e.g., a host is a cloud VPS) so they are not part of core.
    i18n = {
      defaultLocale = lib.mkDefault "en_US.UTF-8";
      supportedLocales = [
        (config.i18n.defaultLocale + "/UTF-8")
        "el_GR.UTF-8/UTF-8"
      ];
    };
    time.timeZone = lib.mkDefault "Europe/Athens";

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
      "d /storage 0755 ${username} users"
      "d /storage/Bravo 0755 ${username} users"
      "d /storage/Omega 0755 ${username} users"
    ];

    fileSystems."/storage/Bravo" = {
      device = "/dev/disk/by-label/Bravo";
      fsType = "ext4";
      options = [
        "noatime"
      ];
    };

    fileSystems."/storage/Omega" = {
      device = "/dev/disk/by-label/Omega";
      fsType = "ntfs";
      options = [
        "noatime,uid=1000,gid=100,rw,user,exec,umask=000 0 0"
      ];
    };
  };
}
