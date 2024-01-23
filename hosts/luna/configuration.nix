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
      kernelParams = ["ipv6.disable=1"];
    };

    zramSwap = {
      enable = true;
      algorithm = "zstd";
    };

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

    fileSystems."/home/${username}/truenas_smb" = {
      device = "//truenas/data";
      fsType = "cifs";
      options = let
        automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
      in ["${automount_opts},credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    };
  };
}
