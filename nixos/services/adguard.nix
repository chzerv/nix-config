{
  config,
  pkgs,
  lib,
  ...
}: let
  opts = config.custom.nix;
in {
  config = lib.mkIf opts.services.adguard {
    services.adguardhome = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      port = 3000;
      settings = {
        schema_version = pkgs.adguardhome.schema_version;
      };
      mutableSettings = true;
      allowDHCP = true; # Adds the `CAP_NET_RAW` capability which is required for the DHCP server
    };

    # systemd-resolved is using port 53, which is also used by Adguard since its a DNS server.
    services.resolved.enable = false;

    networking.firewall = {
      allowedUDPPorts = [53];
    };
  };
}
