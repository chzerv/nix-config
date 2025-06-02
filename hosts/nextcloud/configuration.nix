{
  username,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../nixos
  ];

  config = {
    system = {
      firewall.enable = true;
      sysctl_hardening.enable = true;
      openssh.enable = true;
      node_exporter.enable = true;
      podman.enable = true;
      systemd-boot.enable = true;
      nextcloud.enable = true;
    };

    system.stateVersion = "25.05";

    sops = {
      age.keyFile = null;
    };

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
          ];
        };
      };
    };

    # Static IP
    networking = {
      usePredictableInterfaceNames = false;
      interfaces.eth0.ipv4.addresses = [
        {
          address = "192.168.1.41";
          prefixLength = 24;
        }
      ];
      defaultGateway = "192.168.1.1";
      nameservers = ["192.168.1.20"];
    };

    nix.settings.trusted-users = [username];
  };
}
