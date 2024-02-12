{
  lib,
  config,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos
  ];

  config = {
    local.sys = {
      security = {
        firewall = true;
        sysctl_hardening = true;
      };
      services = {
        openssh = true;
        tailscale = {
          enable = false;
          routingFeatures = "client";
        };
      };
    };

    system.stateVersion = "23.11";

    services = {
      openssh.settings.PermitRootLogin = "yes";
      qemuGuest.enable = true;
    };

    # Secrets
    sops = {
      age.keyFile = null;
      secrets = {
        "attic/credentials" = {};
      };
    };

    # Create user and setup SSH keys
    # NOTE: The root user has a password set by the VM template. Don't forget to change it
    # and also set a password for the new user.
    users = {
      users = {
        ${username} = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiulyvJZgSwvB4BLPaT73nEBBP/N3cClBteYYENH2/u chzerv@DESKTOP-MA88Q7C"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3BmmYPJFi2QBh7luMiYgRqGaZJUM6B7mtgs6AjkYAl chzerv@vader"
          ];
        };
        root = {
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiulyvJZgSwvB4BLPaT73nEBBP/N3cClBteYYENH2/u chzerv@DESKTOP-MA88Q7C"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3BmmYPJFi2QBh7luMiYgRqGaZJUM6B7mtgs6AjkYAl chzerv@vader"
          ];
        };
      };
    };

    # GRUB
    boot = {
      kernelParams = ["console=tty0"];
      loader = {
        grub = {
          device = lib.mkForce "nodev";
          efiSupport = true;
          efiInstallAsRemovable = true;
        };
      };
    };

    services.atticd = {
      enable = true;
      credentialsFile = config.sops.secrets."attic/credentials".path;
      settings = {
        listen = "[::]:8080";
        chunking = {
          nar-size-threshold = 64 * 1024; # 64 KiB
          min-size = 16 * 1024; # 16 KiB
          avg-size = 64 * 1024; # 64 KiB
          max-size = 256 * 1024; # 256 KiB
        };
        garbage-collection = {
          interval = "1 week";
          default-retention-period = "3 months";
        };
        storage = {
          type = "s3";
          bucket = "nix-cache";
          region = "us-east-1";
          endpoint = "https://minio.chrizer.xyz";
        };
      };
    };
  };
}
