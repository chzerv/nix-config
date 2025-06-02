{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.system.nextcloud;
in {
  options.system.nextcloud = {
    enable = lib.mkEnableOption "Deploy Nextcloud";
  };

  config = lib.mkIf cfg.enable {
    sops = {
      secrets = {
        # Nextcloud admin password.
        nextcloudAdminPass = {
          mode = "0440";
          owner = config.users.users.nextcloud.name;
        };

        # Secret used for JWT generation by OnlyOffice, so the token remains the same after reboots etc.
        onlyofficeJWT = {
          mode = "0440";
        };
      };

      # Create the environment file that will be mounted inside the OnlyOffice container.
      templates."onlyoffice_env" = {
        content = ''
          JWT_SECRET=${config.sops.placeholder.onlyofficeJWT}
        '';
      };
    };

    users.users.nextcloud.extraGroups = ["users"];

    # Store Nextcloud data on an NFS share (exported from TrueNAS).
    # Tip: To avoid permission related trouble:
    #       - Ensure the "nextcloud" user and group exist on TrueNAS with UID and GID of `990`.
    #       - Set the dataset's owner and group to the "nextcloud" .
    #       - On the NFS share, set `mapall user` and `mapall group` to "nextcloud".
    systemd.tmpfiles.rules = [
      "d /mnt/nextcloud-data 0755 nextcloud nextcloud"
      "d /mnt/nextcloud-data/config 0755 nextcloud nextcloud"
    ];

    fileSystems."/mnt/nextcloud-data" = {
      device = "192.168.1.11:/mnt/tank/nextcloud";
      fsType = "nfs";
      options = ["rw" "hard" "intr" "noatime" "_netdev"];
    };

    # Needed for adding SMB external storage.
    environment.systemPackages = with pkgs; [
      cifs-utils
      samba
    ];

    services = {
      nextcloud = {
        enable = true;
        package = pkgs.nextcloud31;
        hostName = "nc.chzerv.dev";
        https = true;
        datadir = "/mnt/nextcloud-data";

        # Setup admin user+pass and use Postgres as the database.
        config = {
          dbtype = "pgsql";
          adminuser = "chzerv";
          adminpassFile = "${config.sops.secrets.nextcloudAdminPass.path}";
        };

        # Automatically create the Postgres database and configure Redis.
        database.createLocally = true;
        configureRedis = true;

        settings = {
          default_phone_region = "GR";
          trusted_proxies = ["127.0.0.1"];
          trusted_domains = ["127.0.0.1" "nc.chzerv.dev"];
        };

        maxUploadSize = "16G"; # Also sets post_max_size and memory_limit

        phpOptions = {
          # Suggested by Nextcloud's health check.
          "opcache.interned_strings_buffer" = "16";
        };

        # Nextcloud apps.
        extraApps = {
          inherit (config.services.nextcloud.package.packages.apps) contacts calendar tasks notes onlyoffice;
        };
        extraAppsEnable = true;
      };
    };

    # OnlyOffice does not seem to work when using the Nix module, but works great as a container.
    virtualisation.oci-containers.containers.onlyoffice = {
      image = "onlyoffice/documentserver:latest";
      ports = ["8000:80"];
      environmentFiles = [
        config.sops.templates.onlyoffice_env.path
      ];
    };

    networking.firewall = {
      allowedTCPPorts = [80 8000];
    };
  };
}
