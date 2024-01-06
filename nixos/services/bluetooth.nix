{config, ...}: let
  opts = config.local.sys;
in {
  hardware.bluetooth = {
    enable = opts.services.bluetooth;

    # Power on the bluetooth controller on boot
    powerOnBoot = true;
  };
}
