{
  config,
  lib,
  ...
}: let
  cfg = config.system.tailscale;
in {
  options.system.tailscale = {
    enable = lib.mkEnableOption "Enable tailscale and configure routing features";
    routingFeatures = lib.mkOption {
      type = lib.types.nullOr (lib.types.enum ["client" "server" "none" "both"]);
      default = "client";
    };
  };

  config = lib.mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      # Note: for a subnet router, IP forwarding must be turned on.
      # Luckily, Nix handles that for us:
      # https://github.com/NixOS/nixpkgs/blob/677ed08a50931e38382dbef01cba08a8f7eac8f6/nixos/modules/services/networking/tailscale.nix#L85
      useRoutingFeatures = cfg.routingFeatures;
    };

    networking.firewall = {
      allowedUDPPorts = [config.services.tailscale.port];
      trustedInterfaces = [config.services.tailscale.interfaceName];
    };
  };
}
