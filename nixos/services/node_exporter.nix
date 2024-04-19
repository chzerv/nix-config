{config, ...}: let
  opts = config.local.sys;
in {
  services.prometheus.exporters.node = {
    enable = opts.services.node_exporter;
    enabledCollectors = ["systemd"];
    port = 9100;
    openFirewall = true;
  };
}
