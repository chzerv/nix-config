{
  config,
  lib,
  ...
}: let
  cfg = config.system.firewall;
  localsendPort = [53317];
in {
  options.system.firewall = {
    enable = lib.mkEnableOption "Enable the nixos-firewall";
  };

  config = {
    networking.firewall = {
      enable = cfg.enable;
      allowedTCPPorts = config.services.openssh.ports ++ localsendPort;
    };
  };
}
