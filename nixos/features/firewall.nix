{config, ...}: let
  opts = config.features.nix;
  sshPorts = config.services.openssh.ports;
in {
  networking.firewall = {
    enable = opts.firewall;
    allowedTCPPorts = sshPorts;
    extraCommands = ''
      iptables -A nixos-fw -p tcp --source 192.168.1.12/24 -j nixos-fw-accept
      iptables -A nixos-fw -p udp --source 192.168.1.12/24 -j nixos-fw-accept
    '';
  };
}
