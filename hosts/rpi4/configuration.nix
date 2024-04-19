{
  inputs,
  username,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.raspberry-pi-4
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
        adguard = true;
        node_exporter = true;
        tailscale = {
          enable = true;
          routingFeatures = "server";
        };
      };
      virt = {
        docker = true;
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
  };
}
