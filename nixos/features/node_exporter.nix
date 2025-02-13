{config, ...}: let
  opts = config.features.nix;
in {
  services.prometheus.exporters.node = {
    enable = opts.node_exporter;
    enabledCollectors = ["systemd"];
    port = 9100;
    openFirewall = true;
  };
}
