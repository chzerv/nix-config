{
  inputs,
  modulesPath,
  ...
}: let
  system = "x86_64-linux";
  pkgs = inputs.nixpkgs.legacyPackages.${system};
in {
  imports = [
    (modulesPath + "/virtualisation/proxmox-lxc.nix")
    ../../nixos/options.nix
    ../../nixos/services/openssh.nix
    ../../nixos/security
  ];

  config = {
    local.sys = {
      services.openssh = true;
      security = {
        firewall = true;
        sysctl_hardening = true;
      };
    };

    system.stateVersion = "23.11";

    users = {
      users = {
        xci = {
          isNormalUser = true;
          extraGroups = [
            "wheel"
            "users"
            "docker"
          ];
          password = "password";
          openssh.authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH3BmmYPJFi2QBh7luMiYgRqGaZJUM6B7mtgs6AjkYAl chzerv@vader"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOiulyvJZgSwvB4BLPaT73nEBBP/N3cClBteYYENH2/u chzerv@DESKTOP-MA88Q7C"
          ];
        };
      };
    };

    # Install required packages
    environment.systemPackages = with pkgs; [
      wget
      curl
      vim
      tmux
      git
      killall
      htop
      rsync
      docker-compose
    ];

    # Install Docker
    virtualisation.docker.enable = true;

    systemd.timers."pg_backup" = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "5m";
        OnCalendar = "*-*-* 06:00:00";
        Unit = "pg_backup.service";
      };
    };

    systemd.services."pg_backup" = {
      script = ''
        set -eu
        ${pkgs.docker}/bin/docker -t olivez-db pg_dumpall -c -U postgres | ${pkgs.gzip}/bin/gzip > /home/xci/dump_$(date +%Y_%m_%d).sql.gz
      '';
      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
    };
  };
}
