{
  config,
  lib,
  ...
}: let
  opts = config.local.sys;
in {
  config = lib.mkIf opts.services.tailscale.enable {
    services.tailscale = {
      enable = true;
      # Note: for a subnet router, IP forwarding must be turned on.
      # Luckily, Nix handles that for us:
      # https://github.com/NixOS/nixpkgs/blob/677ed08a50931e38382dbef01cba08a8f7eac8f6/nixos/modules/services/networking/tailscale.nix#L85
      useRoutingFeatures = opts.services.tailscale.routingFeatures;
    };

    networking.firewall = {
      allowedUDPPorts = [config.services.tailscale.port];
      trustedInterfaces = ["tailscale0"];
    };
  };
}
