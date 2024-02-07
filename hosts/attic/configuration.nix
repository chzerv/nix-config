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
        attic_server_token = {};
        minio-access-key-id = {};
        minio-secret-access-key = {};
      };
      templates = {
        "attic_creds.env" = {
          content = ''
            ATTIC_SERVER_TOKEN_HS256_SECRET_BASE64=${config.sops.placeholder.attic_server_token}
            AWS_ACCESS_KEY_ID=${config.sops.placeholder.minio-access-key-id}
            AWS_SECRET_ACCESS_KEY=${config.sops.placeholder.minio-secret-access-key}
          '';
        };
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
      credentialsFile = config.sops.templates."attic_creds.env".path;
      settings = {
        listen = "[::]:8080";
        allowed-hosts = ["attic.chrizer.xyz"];
        api-endpoint = "https://attic.chrizer.xyz/";
        database.url = "postgresql://atticd?host=/run/postgresql";
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
          bucket = "attic";
          region = "us-east-1";
          endpoint = "https://storage.chrizer.xyz";
        };
      };
    };

    # Create a Postgres database for attic
    # The "atticd" user is the user the `atticd` service runs as by default
    services.postgresql = {
      enable = true;
      ensureUsers = [
        {
          name = "atticd";
          ensureDBOwnership = true;
        }
      ];
      ensureDatabases = ["atticd"];
    };
  };
}
