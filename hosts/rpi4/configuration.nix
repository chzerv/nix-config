{
  inputs,
  username,
  pkgs,
  config,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
    ./hardware-configuration.nix
    ../../nixos
  ];

  config = {
    system = {
      firewall.enable = true;
      sysctl_hardening.enable = true;
      openssh.enable = true;
      adguard.enable = true;
      node_exporter.enable = true;
      docker.enable = true;
      tailscale = {
        enable = true;
        routingFeatures = "server";
      };
    };

    system.stateVersion = "23.11";

    users = {
      users = {
        ${username} = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "users"
            "power"
            "audio"
            "video"
            "input"
            "render"
          ];
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiulyvJZgSwvB4BLPaT73nEBBP/N3cClBteYYENH2/u chzerv@DESKTOP-MA88Q7C"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3BmmYPJFi2QBh7luMiYgRqGaZJUM6B7mtgs6AjkYAl chzerv@vader"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAABh4yQqX7sPHcvnvvXHcIUtOPsSytChoBkyTARhZWt"
          ];
        };
      };
    };

    # Static IP
    networking = {
      usePredictableInterfaceNames = false;
      interfaces.eth0.ipv4.addresses = [
        {
          address = "192.168.1.20";
          prefixLength = 24;
        }
      ];
      defaultGateway = "192.168.1.1";
      nameservers = ["1.1.1.1"];
    };

    nix.settings.trusted-users = [username];

    # Secrets
    sops = {
      age.keyFile = null;
      secrets = {
        "server_mac" = {};
      };
    };

    systemd.services.wakeonlan = {
      description = "Trigger WoL for the server, after the network is online";

      serviceConfig = {
        Type = "oneshot";
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 120";
        ExecStart = "${pkgs.bash}/bin/sh -c '${pkgs.wakeonlan}/bin/wakeonlan $$(${pkgs.coreutils}/bin/cat ${config.sops.secrets.server_mac.path})'";
        Restart = "on-failure";
      };

      wantedBy = ["multi-user.target"];
      wants = ["network-online.target"];
      after = ["network-online.target"];
    };

    systemd.services.wakeonlan.enable = true;
  };
}
