{
  config,
  lib,
  ...
}: let
  cfg = config.system.bluetooth;
in {
  options.system.bluetooth = {
    enable = lib.mkEnableOption "Enable bluetooth";
  };

  config = {
    hardware.bluetooth = {
      enable = cfg.enable;

      # Power on the bluetooth controller on boot
      powerOnBoot = true;
    };
  };
}
