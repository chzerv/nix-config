{
  config,
  lib,
  ...
}: let
  cfg = config.system.node_exporter;
in {
  options.system.node_exporter = {
    enable = lib.mkEnableOption "Setup Prometheus node_exporter";
  };

  config = {
    services.prometheus.exporters.node = {
      enable = cfg.enable;
      enabledCollectors = ["systemd"];
      port = 9100;
      openFirewall = true;
    };
  };
}
