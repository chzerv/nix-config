{config, ...}: let
  opts = config.features.nix;
  sshPorts = config.services.openssh.ports;
  localsendPort = [53317];
in {
  networking.firewall = {
    enable = opts.firewall;
    allowedTCPPorts = sshPorts ++ localsendPort;
  };
}
