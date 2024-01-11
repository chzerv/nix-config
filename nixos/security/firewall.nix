{config, ...}: let
  opts = config.local.sys;
  sshPort = config.services.openssh.ports;
in {
  networking.firewall = {
    enable = opts.security.firewall;
    # Only works with nftables
    # extraInputRules = ''
    #   "ip saddr 192.168.1.12 accept"
    # '';
    allowedTCPPorts = sshPort;
    extraCommands = ''
      iptables -A nixos-fw -p tcp --source 192.168.1.12/24 -j nixos-fw-accept
      iptables -A nixos-fw -p udp --source 192.168.1.12/24 -j nixos-fw-accept
    '';
  };
}
