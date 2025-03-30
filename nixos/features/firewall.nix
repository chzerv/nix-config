{config, ...}: let
  opts = config.features.nix;
  sshPorts = config.services.openssh.ports;
in {
  networking.firewall = {
    enable = opts.firewall;
    allowedTCPPorts = sshPorts;
  };
}
