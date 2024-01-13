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
        tailscale = {
          enable = false;
          routingFeatures = "client";
        };
      };
      desktop = {
        gaming = true;
        flatpak = true;
        plymouth = true;
      };
      virt = {
        podman = true;
        docker = false;
        libvirt = true;
        vagrant = true;
      };
    };

    # These might differ from host to host (e.g., a host is a cloud VPS) so they are not part of core.
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";
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
      kernelParams = ["ipv6.disable=1"];
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
    # Mount additional disks and network shares
    ##############################################

    # Use a template to create a file containing the necessary credentials for connecting to my SMB share
    # See: https://github.com/Mic92/sops-nix#templates

    sops.secrets = {
      smb_user = {};
      smb_password = {};
      smb_domain = {};
    };

    sops.templates."smb_secrets" = {
      content = ''
        username=${config.sops.placeholder.smb_user}
        domain=${config.sops.placeholder.smb_domain}
        password=${config.sops.placeholder.smb_password}
      '';
      path = "/etc/nixos/smb-secrets";
    };

    fileSystems."/home/${username}/truenas_smb" = {
      device = "//truenas/data";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    };

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
